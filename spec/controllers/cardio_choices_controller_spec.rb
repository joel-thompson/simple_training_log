require 'rails_helper'

RSpec.describe CardioChoicesController, type: :controller do

  fixtures :users

  before do
    @user = users(:michael)
    @other_user = users(:archer)
    @cardio_choice = @user.cardio_choices.create(
      name: 'run'
    )
  end

  describe "#edit" do
    it "redirects to root if wrong user" do
      log_in_as @other_user
      get :edit, params: {
        id: @cardio_choice.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#create" do
    it "creates a record" do
      log_in_as @user
      expect{
        post :create, params: {
          cardio_choice: {
            name: 'running'
          }
        }
      }.to change{CardioChoice.count}.by(1)
    end
  end

  describe "#update" do
    it "updates a record" do
      log_in_as @user
      put :update, params: {
        id: @cardio_choice.id,
        cardio_choice: {
          name: 'running foo'
        }
      }
      expect(@cardio_choice.reload.name).to eq 'running foo'
    end
  end

  describe "#destroy" do
    it "destroys a record" do
      log_in_as @user
      expect{
        delete :destroy, params: { id: @cardio_choice.id }
      }.to change{CardioChoice.count}.by(-1)
    end
  end

end
