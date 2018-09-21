require 'rails_helper'

RSpec.describe LiftChoicesController, type: :controller do

  fixtures :users, :lift_choices

  let(:user) { users(:weight_lifter) }
  let(:other_user) { users(:joel) }

  let(:lift_choice) { lift_choices(:squat) }

  describe "#index" do
    it "redirects to login if logged out" do
      get :index
      expect(response).to redirect_to(login_url)
    end
  end

  describe "#new" do
    it "redirects to login if logged out" do
      get :new
      expect(response).to redirect_to(login_url)
    end
  end

  describe "#edit" do
    it "redirects to root if wrong user" do
      log_in_as other_user
      get :edit, params: {
        id: lift_choice.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#create" do
    it "creates a record" do
      log_in_as user
      expect{
        post :create, params: {
          lift_choice: {
            name: 'barbell row',
            has_weight: true,
            default_sets: 3,
            default_reps: 5
          }
        }
      }.to change{LiftChoice.count}.by(1)
    end
  end

  describe "#update" do
    it "updates a record" do
      log_in_as user
      put :update, params: {
        id: lift_choice.id,
        lift_choice: {
          name: 'barbell row foo'
        }
      }
      expect(lift_choice.reload.name).to eq 'barbell row foo'
    end
  end

  describe "#destroy" do
    it "destroys a record" do
      log_in_as user
      expect{
        delete :destroy, params: { id: lift_choice.id }
      }.to change{LiftChoice.count}.by(-1)
    end
  end

end
