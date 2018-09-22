require 'rails_helper'
RSpec.describe AddDefaultCardioChoicesWorker, type: :worker do
  fixtures :users

  let(:user) { users(:michael) }
  let(:other_user) { users(:joel) }

  describe 'sidekiq enqueueing' do
    it "enqueues a job" do
      AddDefaultCardioChoicesWorker.perform_async(user.id)
      expect(AddDefaultCardioChoicesWorker).to have_enqueued_sidekiq_job(user.id)
    end
  end

  describe 'when run on a new user' do
    it "creates 1 lift choices" do
      # @user.cardio_choices.destroy_all  -- probably don't need this but leaving for context
      expect {
        AddDefaultCardioChoicesWorker.new.perform(user.id)
      }.to change{CardioChoice.count}.by(1)
    end

    it "adds the lifts" do
      AddDefaultCardioChoicesWorker.new.perform(user.id)
      choice_names = user.cardio_choices.map { |lc| lc.name.downcase }
      expect(choice_names.include?('run')).to eq true
    end
  end

end
