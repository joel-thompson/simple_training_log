# == Schema Information
#
# Table name: lift_choices
#
#  id           :integer          not null, primary key
#  default_sets :integer
#  default_reps :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  has_weight   :boolean
#  user_id      :integer
#  name         :string
#

require 'rails_helper'

RSpec.describe LiftChoice, type: :model do

  fixtures :users

  before do
    @user  = users(:michael)
    @other_user = users(:joel)
    @squat = @user.lift_choices.new(
      has_weight: true
    )
  end

  describe "validations" do
    it "is invalid without a name" do
      expect(@squat.valid?).to eq false
    end

    it "is valid with a name" do
      @squat.name = "squat"
      expect(@squat.valid?).to eq true
    end

    it "has a short name" do
      @squat.name = 'a' * 51
      expect(@squat.valid?).to eq false
    end

    it "has a unique name for each user" do
      @user.lift_choices.create(
        name: 'deadlift',
        has_weight: false
      )
      deadlift = @user.lift_choices.build(
        name: 'Deadlift',
        has_weight: false
      )
      expect(deadlift.valid?).to eq false
    end

    it "allows same name for multiple users" do
      @other_user.lift_choices.create(
        name: 'deadlift',
        has_weight: false
      )
      deadlift = @user.lift_choices.build(
        name: 'deadlift',
        has_weight: false
      )
      expect(deadlift.valid?).to eq true
    end

    it "has value for has_weight" do
      @squat.has_weight = nil
      expect(@squat.valid?).to eq false
    end
  end

  describe 'before save' do
    it "downcases the name" do
      @kipping_pullup = @user.lift_choices.create(
        has_weight: true,
        name: 'KIPPING PULLUP'
      )
      expect(@kipping_pullup.name).to eq 'kipping pullup'
    end
  end

  describe "#friendly_name" do
    it "returns the nice name" do
      @squat.name = "barbell squat"
      expect(@squat.friendly_name).to eq "Barbell Squat"
    end
  end

  describe '#last_occurred' do
    it "returns the last occurred for the user and choice" do
      squat = @user.lift_choices.create(
        name: 'squat',
        has_weight: false
      )

      other_squat = @other_user.lift_choices.create(
        name: 'squat',
        has_weight: false
      )

      squat.lifts.create(
        occurred_date: Date.current,
        occurred_time: 'morning',
        sets: 3,
        reps: 3
      )

      recent = squat.lifts.create(
        occurred_date: Date.current,
        occurred_time: 'afternoon',
        sets: 3,
        reps: 3
      )

      other_squat.lifts.create(
        occurred_date: Date.current,
        occurred_time: 'evening',
        sets: 3,
        reps: 3
      )

      expect(squat.last_occurred).to eq recent
    end
  end

end
