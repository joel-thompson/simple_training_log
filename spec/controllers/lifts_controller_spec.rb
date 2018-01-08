require 'rails_helper'

RSpec.describe LiftsController, type: :controller do

  fixtures :users

  before do
    @user = users(:michael)
    @other_user = users(:archer)

    @lift_choice = @user.lift_choices.create(
      name: 'barbell squat',
      has_weight: true
    )

    @create_lift_params = {
      lift_choice_id: @lift_choice.id,
      lift: {
        occurred_date: Date.today,
        occurred_time: 'morning',
        weight: 70.0,
        sets: 3,
        reps: 5
      }
    }

    @lift = @lift_choice.lifts.create(@create_lift_params[:lift])
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
        lift_choice_id: @lift_choice.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#create' do
    it "redirects to root if incorrect user" do
      log_in_as @other_user
      post :create, params: @create_lift_params
      expect(response).to redirect_to(root_url)
    end

    it "creates" do
      log_in_as @user
      expect{
        post :create, params: @create_lift_params
      }.to change{Lift.count}.by(1)
    end
  end

  describe '#edit' do
    it "redirects to root if incorrect user" do
      log_in_as @other_user
      get :edit, params: {
        id: @lift.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#update' do
    it "updates" do
      log_in_as @user
      put :update, params: {
        id: @lift.id,
        lift: {
          weight: 1337
        }
      }
      expect(@lift.reload.weight).to eq 1337
    end
    it "redirects and does not update if wrong user" do
      log_in_as @other_user
      put :update, params: {
        id: @lift.id,
        lift: {
          weight: 15
        }
      }
      expect(@lift.reload.weight).to_not eq 15
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#show' do
    it "redirects to root if incorrect user" do
      log_in_as @other_user
      get :show, params: {
        id: @lift.id
      }
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#destroy' do
    it "destroys" do
      log_in_as @user
      expect {
        delete :destroy, params: {
          id: @lift.id
        }
      }.to change{Lift.count}.by(-1)
    end

    it "redirects and does not destroy if wrong user" do
      log_in_as @other_user
      expect {
        delete :destroy, params: {
          id: @lift.id
        }
      }.to_not change{Lift.count}
      expect(response).to redirect_to(root_url)
    end
  end

end
