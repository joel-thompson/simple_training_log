require 'rails_helper'



RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar",
              password_confirmation: "foobar")
  end

  describe "user" do
    it "should be valid" do
      expect(@user.valid?).to eql(true)
    end

    it "should have a name" do
      @user.name = "    "
      expect(@user.valid?).to eql(false)
    end

    it "should have an email" do
      @user.email = "   "
      expect(@user.valid?).to eql(false)
    end

    it "should not have a long name" do
      @user.name = "a" * 51
      expect(@user.valid?).to eql(false)
    end

    it "should not have a long email" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user.valid?).to eql(false)
    end

    it "should accept valid email addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
  							first.last@foo.jp alice+bob@baz.cn]

      valid_addresses.each do |valid_address|
  			@user.email = valid_address
  			# assert @user.valid?, "#{valid_address.inspect} should be valid"
        expect(@user.valid?).to eql(true)
  		end
    end

    it "should reject invalid email addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
              foo@bar_baz.com foo@bar+baz.com foo@bar..com]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        # assert @user.valid?, "#{valid_address.inspect} should be valid"
        expect(@user.valid?).to eql(false)
      end
    end

    it "should have a unique email address" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.downcase
      @user.save
      # assert_not duplicate_user.valid?
      expect(duplicate_user.valid?).to eql(false)
    end

    it "should downcase emails before saving" do
      test_email = "USER@EXAMPLE.COM"
      @user.email = test_email
      @user.save
      # assert_equal test_email.downcase, @user.reload.email
      expect(@user.reload.email).to eql(test_email.downcase)
    end

    it "should have a password of a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user.valid?).to eql(false)
    end

    it "does not authenticate a nil digest" do
      expect(@user.authenticated?(:remember, '')).to eql(false)
    end


  end

end
