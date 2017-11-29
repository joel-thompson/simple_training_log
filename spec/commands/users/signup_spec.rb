require 'rails_helper'

describe Users::Signup do
  # let(:app) { apps(:intercom) }
  # let(:admin) { admins(:jeff) }
  # let(:valid_token) { Incrypt::SecureRandomGenerator.new.uuid }
  #
  # it 'should clear the pending validation if one exists' do
  #   admin.email_validation_token = valid_token
  #   admin.pending_email_change = 'bill@microsoft.com'
  #   admin.save!
  #   Admins::CancelVerificationEmail.run!(admin: admin)
  #   expect(admin.pending_email_change).to be_nil
  #   expect(admin.email_validation_token).to be_nil
  # end
  #
  # it 'should throw a validation error if there is no validation pending' do
  #   expect { Admins::CancelVerificationEmail.run!(admin: admin) }.to raise_error(Mutations::ValidationException, "There is no pending validation for this user")
  # end

  it "should create a new user if passed valid inputs" do
    # expect {
    #   Users::Signup.run!(email: "joel@loggingprogress.com", name: "joel", password: "12341234", password_confirmation: "12341234")
    # }.to change{User.count}.by(1)
    # expect(User).to receive(:create!)
    # Users::Signup.run!(email: "joel@loggingprogress.com", name: "joel", password: "12341234", password_confirmation: "12341234")
  end

end
