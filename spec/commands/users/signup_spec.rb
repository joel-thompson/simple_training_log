require 'rails_helper'

describe Users::Signup do

  before do
    @good_user = double()
    allow(@good_user).to receive(:valid?).and_return(true)

    @bad_user = double()
    allow(@bad_user).to receive(:valid?).and_return(false)
    allow(@bad_user).to receive_message_chain(:errors, :to_hash_array, :each)
  end

  it "should create a new user and activate user and not send activation email, if passed valid inputs for activated user" do
    expect(User).to receive(:create).and_return(@good_user)
    expect(@good_user).to_not receive(:send_activation_email)
    expect(@good_user).to receive(:activate)
    Users::Signup.run(
      email: "joel@lp.com",
      name: "joel",
      password: "password",
      password_confirmation: "password",
      activated: true
    )
  end

  it "should create a new user and send activation email, if passed valid inputs for not activated user" do
    expect(User).to receive(:create).and_return(@good_user)
    expect(@good_user).to receive(:send_activation_email)
    expect(@good_user).to_not receive(:activate)
    Users::Signup.run(
      email: "joel@lp.com",
      name: "joel",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "should not create a new user if no email" do
    expect(User).to_not receive(:create)
    Users::Signup.run(
      email: "",
      name: "joel",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "should not create a new user if no name" do
    expect(User).to_not receive(:create)
    Users::Signup.run(
      email: "joel@lp.com",
      name: "",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "should not create a new user if no password" do
    expect(User).to_not receive(:create)
    Users::Signup.run(
      email: "joel@lp.com",
      name: "joel",
      password: "",
      password_confirmation: "password"
    )
  end

  it "should not create a new user if no password confirmation" do
    expect(User).to_not receive(:create)
    Users::Signup.run(
      email: "joel@lp.com",
      name: "joel",
      password: "password",
      password_confirmation: ""
    )
  end

  it "doesn't activate or send activation email if validations fail" do
    expect(User).to receive(:create).and_return(@bad_user)
    expect(@bad_user).to_not receive(:send_activation_email)
    expect(@bad_user).to_not receive(:activate)
    Users::Signup.run(
      email: "foo",
      name: "joel",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "should parse user errors if validations fail" do
    expect(User).to receive(:create).and_return(@bad_user)
    expect(@bad_user).to receive_message_chain(:errors, :to_hash_array, :each)
    Users::Signup.run(
      email: "foo",
      name: "joel",
      password: "password",
      password_confirmation: "password"
    )
  end

end
