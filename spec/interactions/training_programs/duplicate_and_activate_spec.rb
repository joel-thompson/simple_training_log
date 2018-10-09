require 'rails_helper'

module TrainingPrograms
  describe DuplicateAndActivate do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs
    let(:user) { users(:weight_lifter) }
    let(:other_user) { users(:martial_artist) }

    let(:old_program) { training_programs(:previous_starting_strength) }
    let(:active_program) { training_programs(:starting_strength) }

    let(:params) {
      {
        user: user,
        program: old_program,
      }
    }

    context "validation" do
      it "is valid with good params" do
        outcome = TrainingPrograms::DuplicateAndActivate.run(params)
        expect(outcome.valid?).to eq true
      end

      it "is invalid without user" do
        params[:user] = nil
        outcome = TrainingPrograms::DuplicateAndActivate.run(params)
        expect(outcome.errors.messages[:user]).to include("is required")
      end

      it "is invalid without correct user" do
        params[:user] = other_user
        outcome = TrainingPrograms::DuplicateAndActivate.run(params)
        expect(outcome.errors.messages[:user]).to include("does not own this program")
      end

      it "is invalid without program" do
        params[:program] = nil
        outcome = TrainingPrograms::DuplicateAndActivate.run(params)
        expect(outcome.errors.messages[:program]).to include("is required")
      end
    end

    context 'execution' do
      it "creates a new training program record for the user" do
        expect {
          TrainingPrograms::DuplicateAndActivate.run!(params)
        }.to change{user.training_programs.count}.by(1)
      end

      it "returns a copy of the old program" do
        outcome = TrainingPrograms::DuplicateAndActivate.run(params)
        expect(outcome.result.is_a?(TrainingProgram)).to eq true
        expect(outcome.result.name).to eq old_program.name
        expect(outcome.result.notes).to eq old_program.notes

        expect(outcome.result).to_not eq old_program

        expect(outcome.result.activated_at).to eq Time.now
        expect(outcome.result.deactivated_at).to eq nil
      end

      it "creates a copy of the old program" do
        expect(TrainingPrograms::Create).to receive(:run).with(
          user: user,
          name: old_program.name,
          notes: old_program.notes,
          at: Time.now,
        ).and_call_original
        TrainingPrograms::DuplicateAndActivate.run!(params)
      end
    end
  end
end
