require 'rails_helper'

module TrainingPrograms
  describe Update do
    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs

    let(:good_program) { training_programs(:starting_strength) }
    let(:good_name) { "updated name" }
    let(:good_notes) { "updated notes" }

    let(:params) {
      {
        program: good_program,
        name: good_name,
        notes: good_notes,
      }
    }

    context 'validation' do
      it "is valid with good params" do
        outcome = TrainingPrograms::Update.run(params)
        expect(outcome.valid?).to eq true
      end

      it "is invalid without a program" do
        params[:program] = nil
        outcome = TrainingPrograms::Update.run(params)
        expect(outcome.errors.messages[:program]).to include("is required")
      end
    end

    context 'excution' do
      it "returns the updated training program as the result" do
        outcome = TrainingPrograms::Update.run(params)
        expect(outcome.result.is_a?(TrainingProgram)).to eq true
      end

      it "strips leading and trailing whitespace from name and notes" do
        params[:name] = " foo "
        params[:notes] = " bar "
        outcome = TrainingPrograms::Update.run(params)
        expect(outcome.result.name).to eq "foo"
        expect(outcome.result.notes).to eq "bar"
      end

      it "updates the attributes correctly" do
        expect(good_program.name).to_not eq params[:name]
        expect(good_program.notes).to_not eq params[:notes]

        outcome = TrainingPrograms::Update.run(params)
        expect(outcome.result.name).to eq params[:name]
        expect(outcome.result.notes).to eq params[:notes]

        expect(good_program.reload.name).to eq params[:name]
        expect(good_program.reload.notes).to eq params[:notes]
      end
    end
  end
end
