require 'rails_helper'

module TrainingPrograms
  describe List do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs
    let(:user) { users(:weight_lifter) }

    let(:old_program) { training_programs(:previous_starting_strength) }
    let(:active_program) { training_programs(:starting_strength) }

    let(:params) {
      {
        user: user,
      }
    }

    context "validation" do
      it "is valid with good params" do
        outcome = TrainingPrograms::List.run(params)
        expect(outcome.valid?).to eq true
      end

      it "is invalid without user" do
        params[:user] = nil
        outcome = TrainingPrograms::List.run(params)
        expect(outcome.errors.messages[:user]).to include("is required")
      end
    end

    context 'execution' do
      it "lists out the user's training programs, newest first by activated_at" do
        result = TrainingPrograms::List.run(params).result
        expect(result.first).to eq active_program
        expect(result.second).to eq old_program
      end

      it "only lists out programs owned by the user" do
        result = TrainingPrograms::List.run(params).result
        result.each { |program| expect(program.user).to eq user }
      end
    end
  end
end
