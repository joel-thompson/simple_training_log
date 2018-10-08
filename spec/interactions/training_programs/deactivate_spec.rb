require 'rails_helper'

module TrainingPrograms
  describe Deactivate do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs
    let(:good_program) { training_programs(:starting_strength) }

    let(:params) {
      {
        program: good_program,
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
