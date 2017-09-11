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
                                                  password:              User.digest('password'),
                                                  password_confirmation: User.digest('password'),
                                                  admin: true
                            } }

      expect(@other_user.reload.admin?).to eq false
    end

  end

end
