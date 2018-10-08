require 'rails_helper'

module TrainingPrograms
  describe Destroy do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs
    let(:program) { training_programs(:starting_strength) }

    let(:params) {
      {
        program: program,
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
    end

    context 'execution' do
      it "deactivates the program" do
        expect(TrainingPrograms::Deactivate).to receive(:run!).with(program: program)
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
