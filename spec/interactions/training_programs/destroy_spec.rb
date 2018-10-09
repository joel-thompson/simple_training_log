require 'rails_helper'

module TrainingPrograms
  describe Destroy do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs
    let(:program) { training_programs(:starting_strength) }
    let(:user) { users(:weight_lifter) }
    let(:other_user) { users(:martial_artist) }

    let(:params) {
      {
        program: program,
        user: user,
      }
    }

    context "validation" do
      it "is valid with good params" do
        outcome = TrainingPrograms::Destroy.run(params)
        expect(outcome.valid?).to eq true
      end

      it "is invalid without program" do
        params[:program] = nil
        outcome = TrainingPrograms::Destroy.run(params)
        expect(outcome.errors.messages[:program]).to include("is required")
      end

      it "is invalid without user" do
        params[:user] = nil
        outcome = TrainingPrograms::Destroy.run(params)
        expect(outcome.errors.messages[:user]).to include("is required")
      end

      it "is invalid without correct user" do
        params[:user] = other_user
        outcome = TrainingPrograms::Destroy.run(params)
        expect(outcome.errors.messages[:user]).to include("does not own this program")
      end
    end

    context 'execution' do
      it "deactivates the program" do
        expect(TrainingPrograms::Deactivate).to receive(:run).with(
          program: program,
          user: user,
        ).and_call_original
        TrainingPrograms::Destroy.run!(params)
      end

      it "destroys the program" do
        expect {
          TrainingPrograms::Destroy.run!(params)
        }.to change{TrainingProgram.count}.by(-1)
      end
    end
  end
end
