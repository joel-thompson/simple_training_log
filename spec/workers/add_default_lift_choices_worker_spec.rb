require 'rails_helper'
RSpec.describe AddDefaultLiftChoicesWorker, type: :worker do

  fixtures :users

  let(:user) { users(:michael) }
  let(:other_user) { users(:joel) }

  describe 'sidekiq enqueueing' do
    it "enqueues a job" do
      AddDefaultLiftChoicesWorker.perform_async(user.id)
      expect(AddDefaultLiftChoicesWorker).to have_enqueued_sidekiq_job(user.id)
    end
  end

  describe 'when run on a new user' do
    it "creates 3 lift choices" do
      # user.lift_choices.destroy_all  -- probably don't need this but leaving for context
      expect {
        AddDefaultLiftChoicesWorker.new.perform(user.id)
      }.to change{LiftChoice.count}.by(3)
    end

    it "adds the lifts" do
      AddDefaultLiftChoicesWorker.new.perform(user.id)
      choice_names = user.lift_choices.map { |lc| lc.name.downcase }

      expect(choice_names.include?('barbell squat')).to eq true
      expect(choice_names.include?('barbell deadlift')).to eq true
      expect(choice_names.include?('barbell bench press')).to eq true
    end
  end

  describe 'when run on existing user with choices present' do
    it "doesn't overwrite existing choices" do
      other_user.lift_choices.create(
        name: 'barbell bench press',
        has_weight: true,
        default_sets: 2,
        default_reps: 2
      )
      AddDefaultLiftChoicesWorker.new.perform(user.id)

      bench = other_user.reload.lift_choices.find_by(name: 'barbell bench press')

      expect(bench.default_sets).to eq 2
      expect(bench.default_reps).to eq 2
    end
  end

end
