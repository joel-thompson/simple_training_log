require 'rails_helper'

RSpec.describe BodyWeightRecordsController, type: :controller do

  fixtures :users

  before do
    @user = users(:michael)
    @other_user = users(:archer)
    @record = @user.body_weight_records.create(weight: 70.1)
  end

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     # binding.pry
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "#create" do
    it "creates a record" do
      log_in_as @user
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
      log_in_as @user
      post :create, params: {
        weight: 70.1
      }
      expect(RecordIntercomEventWorker).to have_enqueued_sidekiq_job(
        @user.id,
        'Updated Body Weight',
        { weight: 70.1 },
      )
    end
  end

  describe "#destroy" do
    it "destroys a record" do
      log_in_as @user
      expect{
        delete :destroy, params: {
          id: @record.id
        }
      }.to change{BodyWeightRecord.count}.by(-1)
    end

    it "doesn't destroy if not logged in" do
      expect{
        delete :destroy, params: {
          id: @record.id
        }
      }.to_not change{BodyWeightRecord.count}
      expect(response).to redirect_to(login_url)
    end

    it "doesn't destroy someone else's record" do
      log_in_as @other_user
      expect{
        delete :destroy, params: {
          id: @record.id
        }
      }.to_not change{BodyWeightRecord.count}
      expect(response).to redirect_to(root_url)
    end
  end

end
