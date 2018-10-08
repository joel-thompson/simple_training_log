require 'rails_helper'

module TrainingPrograms
  describe Find do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs

    let(:user) { users(:weight_lifter) }
    let(:other_user) { users(:martial_artist) }

    let(:program) { training_programs(:starting_strength) }

    let(:params) {
      {
        id: program.id,
        user: user,
      }
    }

    context "validation" do
      it "is valid with good params" do
        outcome = TrainingPrograms::Find.run(params)
        expect(outcome.valid?).to eq true
      end

      it "is invalid without id" do
        params[:id] = nil
        outcome = TrainingPrograms::Find.run(params)
        expect(outcome.errors.messages[:id]).to include("is required")
      end

      it "is invalid without a user" do
        params[:user] = nil
        outcome = TrainingPrograms::Find.run(params)
        expect(outcome.errors.messages[:user]).to include("is required")
      end
    end

    context 'execution' do
      it "finds the right program" do
        outcome = TrainingPrograms::Find.run(params)
        expect(outcome.result).to eq program
      end

      it "returns nil if looking for a program with the wrong user" do
        params[:user] = other_user
        outcome = TrainingPrograms::Find.run(params)
        expect(outcome.result).to eq nil
      end
    end
  end
end
