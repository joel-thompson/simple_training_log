require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: :controller do

  fixtures :users

  before do
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  describe "Users Controller" do
    it "should use valid users in tests" do
      expect(@user.valid?).to eq true
      expect(@other_user.valid?).to eq true
    end

    it "should not let users make themselves admins via PUT" do
      log_in_as(@other_user)
      expect(@other_user.admin?).to eq false

      put :update, params: { id: @other_user.id , user: {
                                                  password:              "123412345",
                                                  password_confirmation: "123412345",
                                                  admin: true
                            } }

      expect(@other_user.reload.admin?).to eq false
    end

    it "should not allow non admins to delete users" do
      log_in_as(@other_user)
      expect{
        delete :destroy, params: { id: @user.id }
      }.to_not change{User.count}
    end

    it "should not allow non logged in people to delete users" do
      expect{
        delete :destroy, params: { id: @user.id }
      }.to_not change{User.count}
    end

    it "should allow admins to delete users" do
      log_in_as(@user)
      expect{
        delete :destroy, params: { id: @other_user.id }
      }.to change{User.count}.by(-1)
    end

    it "should send activation email when creating" do
      expect(UserMailer).to receive_message_chain(:account_activation, :deliver_now)
      post :create, params: { user: {
                                name: "mailtest",
                                email: "mail@test.com",
                                password:              "12341234",
                                password_confirmation: "12341234"
                              }
                            }
    end

  end

end
