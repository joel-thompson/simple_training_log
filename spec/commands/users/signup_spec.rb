require 'rails_helper'

describe Users::Signup do

  it "should create a new user and activate user and not send activation email, if passed valid inputs for activated user" do
    user = double()
    expect(User).to receive(:create!).and_return(user)
    allow(user).to receive(:valid?).and_return(true)
    expect(user).to_not receive(:send_activation_email)
    expect(user).to receive(:activate)
    Users::Signup.run(
      email: "joel@lp.com",
      name: "joel",
      password: "password",
      password_confirmation: "password",
      activated: true
    )
  end

  it "should create a new user and send activation email, if passed valid inputs for not activated user" do
    user = double()
    expect(User).to receive(:create!).and_return(user)
    allow(user).to receive(:valid?).and_return(true)
    expect(user).to receive(:send_activation_email)
    expect(user).to_not receive(:activate)
    Users::Signup.run(
      email: "joel@lp.com",
      name: "joel",
      password: "password",
      password_confirmation: "password"
    )
  end

end
