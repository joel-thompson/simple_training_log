require 'rails_helper'

RSpec.describe CardiosController, type: :controller do
  fixtures :users

  before do
    @user = users(:michael)
    @other_user = users(:archer)

    @cardio_choice = @user.cardio_choices.create(
      name: 'run'
    )

    @create_cardio_params = {
      cardio_choice_id: @cardio_choice.id,
      cardio: {
        occurred_date: Date.current,
        occurred_time: 'morning',
        duration_in_seconds: 90
      }
    }

    @cardio = @cardio_choice.cardios.create(@create_cardio_params[:cardio])
  end

  describe "general" do
    it "redirects to login if logged out" do
      get :index
      expect(response).to redirect_to(login_url)
    end
  end

  describe '#index' do
    it "redirects to home page if logged in" do
      log_in_as @user
      get :index
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#new' do
    it "redirects to root if incorrect user" do
      log_in_as @other_user
      get :new, params: {
        cardio_choice_id: @cardio_choice.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#create' do
    it "redirects to root if incorrect user" do
      log_in_as @other_user
      post :create, params: @create_cardio_params
      expect(response).to redirect_to(root_url)
    end

    it "creates" do
      log_in_as @user
      expect{
        post :create, params: @create_cardio_params
      }.to change{Cardio.count}.by(1)
    end
  end

  describe '#edit' do
    it "redirects to root if incorrect user" do
      log_in_as @other_user
      get :edit, params: {
        id: @cardio.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#update' do
    it "updates" do
      log_in_as @user
      put :update, params: {
        id: @cardio.id,
        cardio: {
          duration_in_seconds: 1337
        }
      }
      expect(@cardio.reload.duration_in_seconds).to eq 1337
    end
    it "redirects and does not update if wrong user" do
      log_in_as @other_user
      put :update, params: {
        id: @cardio.id,
        cardio: {
          duration_in_seconds: 15
        }
      }
      expect(@cardio.reload.duration_in_seconds).to_not eq 15
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#show' do
    it "redirects to root if incorrect user" do
      log_in_as @other_user
      get :show, params: {
        id: @cardio.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#destroy' do
    it "destroys" do
      log_in_as @user
      expect {
        delete :destroy, params: {
          id: @cardio.id
        }
      }.to change{Cardio.count}.by(-1)
    end

    it "redirects and does not destroy if wrong user" do
      log_in_as @other_user
      expect {
        delete :destroy, params: {
          id: @cardio.id
        }
      }.to_not change{Cardio.count}
      expect(response).to redirect_to(root_url)
    end
  end

end
