require 'rails_helper'

RSpec.describe BodyWeightRecordsController, type: :controller do

  fixtures :users
  fixtures :body_weight_records

  let(:user) { users(:user_with_body_weight_records) }
  let(:other_user) { users(:archer) }
  let(:record) { body_weight_records(:most_recent) }

  describe "#create" do
    it "creates a record" do
      now = Time.now
      travel_to now
      log_in_as user
      expect{
        post :create, params: {
            weight: 70.1
        }
      }.to change{BodyWeightRecord.count}.by(1)
      expect(response).to redirect_to(root_url)
    end

    it "doens't create if not logged in" do
      expect{
        post :create, params: {
            weight: 70.1
        }
      }.to_not change{BodyWeightRecord.count}
      expect(response).to redirect_to(login_url)
    end

    it "calls to the event worker" do
      now = Time.now + 1.minute # bad but i need to do this to avoid state of the nation errors.
      travel_to now
      log_in_as user
      post :create, params: {
        weight: 70.1
      }
      expect(RecordIntercomEventWorker).to have_enqueued_sidekiq_job(
        user.id,
        'Updated Body Weight',
        { weight: 70.1 },
        now.to_i,
      )
    end
  end

  describe "#destroy" do
    it "destroys a record" do
      log_in_as user
      expect{
        delete :destroy, params: {
          id: record.id
        }
      }.to change{BodyWeightRecord.count}.by(-1)
    end

    it "calls to the event worker" do
      now = Time.now
      travel_to now
      log_in_as user
      delete :destroy, params: {
        id: record.id
      }
      expect(RecordIntercomEventWorker).to have_enqueued_sidekiq_job(
        user.id,
        'Deleted Body Weight Record',
        { weight: 40 },
        now.to_i,
      )
    end

    it "doesn't destroy if not logged in" do
      expect{
        delete :destroy, params: {
          id: record.id
        }
      }.to_not change{BodyWeightRecord.count}
      expect(response).to redirect_to(login_url)
    end

    it "doesn't destroy someone else's record" do
      log_in_as other_user
      expect{
        delete :destroy, params: {
          id: record.id
        }
      }.to_not change{BodyWeightRecord.count}
      expect(response).to redirect_to(root_url)
    end
  end

end
