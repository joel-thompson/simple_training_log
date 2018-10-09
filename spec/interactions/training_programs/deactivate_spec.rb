require 'rails_helper'

module TrainingPrograms
  describe Deactivate do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs
    let(:user) { users(:weight_lifter) }
    let(:other_user) { users(:martial_artist) }
    let(:good_program) { training_programs(:starting_strength) }

    let(:params) {
      {
        program: good_program,
        user: user,
      }
    }

    context "validation" do
      it "is valid with good params" do
        outcome = TrainingPrograms::Deactivate.run(params)
        expect(outcome.valid?).to eq true
      end

      it "is invalid without program" do
        params[:program] = nil
        outcome = TrainingPrograms::Deactivate.run(params)
        expect(outcome.errors.messages[:program]).to include("is required")
      end

      it "is invalid without user" do
        params[:user] = nil
        outcome = TrainingPrograms::Deactivate.run(params)
        expect(outcome.errors.messages[:user]).to include("is required")
      end

      it "is invalid without correct user" do
        params[:user] = other_user
        outcome = TrainingPrograms::Deactivate.run(params)
        expect(outcome.errors.messages[:user]).to include("does not own this program")
      end
    end

    context 'execution' do
      it "returns the updated training program as the result" do
        outcome = TrainingPrograms::Deactivate.run(params)
        expect(outcome.result.is_a?(TrainingProgram)).to eq true
      end

      it "deactivates the program correctly" do
        expect(good_program.deactivated_at).to eq nil

        outcome = TrainingPrograms::Deactivate.run(params)
        expect(outcome.result.deactivated_at).to eq Time.now

        expect(good_program.reload.deactivated_at).to eq Time.now
      end

      it "deactivates on a future date when passed in" do
        params[:at] = Time.now + 1.day

        expect(good_program.deactivated_at).to eq nil

        outcome = TrainingPrograms::Deactivate.run(params)
        expect(outcome.result.deactivated_at).to eq params[:at]

        expect(good_program.reload.deactivated_at).to eq params[:at]
      end
    end
  end
end
