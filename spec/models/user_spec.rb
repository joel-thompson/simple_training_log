# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  activation_digest :string
#  admin             :boolean          default(FALSE)
#  email             :string
#  name              :string
#  password_digest   :string
#  remember_digest   :string
#  reset_digest      :string
#  reset_sent_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'rails_helper'



RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  fixtures :users

  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar",
              password_confirmation: "foobar")

    @saved_user = User.create(name: "Saved", email: "saved@example.com", password: "foobar",
              password_confirmation: "foobar")
    @updateme = users(:joel)
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
        expect(@user.valid?).to eql(true)
  		end
    end

    it "should reject invalid email addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
              foo@bar_baz.com foo@bar+baz.com foo@bar..com]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.valid?).to eql(false)
      end
    end

    it "should have a unique email address" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.downcase
      @user.save
      expect(duplicate_user.valid?).to eql(false)
    end

    it "should downcase emails before saving" do
      test_email = "USER@EXAMPLE.COM"
      @user.email = test_email
      @user.save
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

  describe "when listing entries" do

    # is not currently testing for the order returned
    it "lists all entries" do
      sesh = @saved_user.martial_arts.create(
        duration_in_seconds: 60,
        occurred_time: "morning",
        occurred_date: Date.current
      )
      expect(@saved_user.all_entries).to include(sesh)
    end
  end

  describe "#current_weight" do
    it "returns correct weight" do
      record_1 = @saved_user.body_weight_records.create(weight: 75.5, weighed_at: Time.now)
      travel_to Time.now + 10.seconds
      record_1.update(expired_at: Time.now)
      @saved_user.body_weight_records.create(weight: 85.5, weighed_at: Time.now)
      expect(@saved_user.reload.current_weight).to eq 85.5
    end
  end

  describe "#update_weight" do
    it "creates a new body_weight_record" do
      expect{
        @saved_user.update_weight(99.1)
      }.to change{BodyWeightRecord.count}.by(1)
    end

    it "updates the current weight" do
      @saved_user.update_weight(99.5)
      expect(@saved_user.current_weight).to eq 99.5
    end
  end

  describe "#set_default_lift_choices" do
    it "enqueues the sidekiq job on create" do
      expect(AddDefaultLiftChoicesWorker).to have_enqueued_sidekiq_job(@saved_user.id)
    end

    it "does not enqueue the sidekiq job on updates" do
      @updateme.update(name: 'update')
      expect(AddDefaultLiftChoicesWorker).to_not have_enqueued_sidekiq_job(@updateme.id)
    end
  end

  describe "#set_default_cardio_choices" do
    it "enqueues the sidekiq job on create" do
      expect(AddDefaultCardioChoicesWorker).to have_enqueued_sidekiq_job(@saved_user.id)
    end

    it "does not enqueue the sidekiq job on updates" do
      @updateme.update(name: 'update')
      expect(AddDefaultCardioChoicesWorker).to_not have_enqueued_sidekiq_job(@updateme.id)
    end
  end

  describe "having many lifts through lift choices" do

    it "can find the lifts through #lifts" do
      squat = @saved_user.lift_choices.create(
        name: 'barbell squat bro',
        has_weight: true,
        default_sets: 3,
        default_reps: 5
      )
      squat_record = squat.lifts.create(
        occurred_date: Date.current,
        occurred_time: 'morning'
      )

      expect(@saved_user.lifts).to include(squat_record)
    end

  end

  describe "having many cardios through cardio choices" do
    it "can find the cardios through #lifts" do
      run = @saved_user.cardio_choices.create(
        name: 'run'
      )
      run_record = run.cardios.create(
        occurred_date: Date.current,
        occurred_time: 'morning',
        duration_in_seconds: 60
      )

      expect(@saved_user.cardios).to include(run_record)
    end
  end

end
