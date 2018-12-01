require 'rails_helper'

module TrainingPrograms
  describe Create do

    before { Timecop.freeze(Time.now) }

    fixtures :users, :training_programs

    let(:old_program) { training_programs(:starting_strength) }

    let(:good_user) { users(:weight_lifter) }
    let(:good_name) { "the program of cool" }
    let(:good_notes) { "do lots of stuff" }
    let(:good_schedule) { "monday: do stuff" }

    let(:params) {
      {
        user: good_user,
        name: good_name,
        notes: good_notes,
        schedule: good_schedule,
      }
    }

    context 'validation' do
      it "is valid with good params" do
        outcome = TrainingPrograms::Create.run(params)
        expect(outcome.valid?).to eq true
      end

      context 'user' do
        it "is invalid without a user" do
          params[:user] = nil
          outcome = TrainingPrograms::Create.run(params)
          expect(outcome.errors.messages[:user]).to include("is required")
        end
      end

      context 'name' do
        it "is invalid without a name" do
          params[:name] = nil
          outcome = TrainingPrograms::Create.run(params)
          expect(outcome.errors.messages[:name]).to include("is required")
        end

        it "is invalid with a blank string name" do
          params[:name] = ""
          outcome = TrainingPrograms::Create.run(params)
          expect(outcome.errors.messages[:name]).to include("can't be blank")
        end

        it "is invalid without a name at most 50 characters" do
          params[:name] = "a" * 51
          outcome = TrainingPrograms::Create.run(params)
          expect(outcome.errors.messages[:name]).to include("is too long (maximum is 50 characters)")
        end
      end

      context 'notes' do
        it "is invalid without notes" do
          params[:notes] = nil
          outcome = TrainingPrograms::Create.run(params)
          expect(outcome.errors.messages[:notes]).to include("is required")
        end

        it "is invalid with blank notes" do
          params[:notes] = ""
          outcome = TrainingPrograms::Create.run(params)
          expect(outcome.errors.messages[:notes]).to include("can't be blank")
        end
      end
    end

    context 'excution' do
      it "creates a new training program record for the user" do
        expect {
          TrainingPrograms::Create.run!(params)
        }.to change{good_user.training_programs.count}.by(1)
      end

      it "expires the previously active program" do
        expect(old_program.deactivated_at).to eq nil
        expect(TrainingPrograms::Deactivate).to receive(:run).with(
          program: old_program,
          user: good_user,
          at: Time.now,
        ).and_call_original
        TrainingPrograms::Create.run!(params)
      end

      it "sets activated_at" do
        outcome = TrainingPrograms::Create.run(params)
        expect(outcome.result.activated_at).to eq Time.now

        future_time = Time.now + 5.days
        params[:at] = future_time
        outcome = TrainingPrograms::Create.run(params)
        expect(outcome.result.activated_at).to eq future_time
      end

      it "returns the new training program as the result" do
        outcome = TrainingPrograms::Create.run(params)
        expect(outcome.result.is_a?(TrainingProgram)).to eq true
      end

      it "strips leading and trailing whitespace from name and notes and schedule" do
        params[:name] = " foo "
        params[:notes] = " bar "
        params[:schedule] = " baz "
        outcome = TrainingPrograms::Create.run(params)
        expect(outcome.result.name).to eq "foo"
        expect(outcome.result.notes).to eq "bar"
        expect(outcome.result.schedule).to eq "baz"
      end
    end
  end
end
