# == Schema Information
#
# Table name: lifts
#
#  id             :integer          not null, primary key
#  lift_choice_id :integer
#  weight         :float
#  sets           :integer
#  reps           :integer
#  occurred_date  :date
#  occurred_time  :string
#  location       :string
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  last_amrap_set :integer
#

require 'rails_helper'

RSpec.describe Lift, type: :model do

  fixtures :users

  before do
    @user = users(:michael)
    @squat = @user.lift_choices.create(
      name: 'barbell squat',
      has_weight: true,
      default_sets: 3,
      default_reps: 5
    )
    @squat_record = @squat.lifts.create(
      occurred_date: Date.current,
      occurred_time: 'morning',
      weight: 70.8
    )
  end

  describe "validations" do
    it "is valid when all info is present" do
      expect(@squat_record.valid?).to eq true
    end

    it "is invalid without occurred_date" do
      @squat_record.occurred_date = nil
      expect(@squat_record.valid?).to eq false
    end

    it "is invalid without occurred_time" do
      @squat_record.occurred_time = nil
      expect(@squat_record.valid?).to eq false
    end

    it "is invalid without a valid occurred_time" do
      @squat_record.occurred_time = 'after breakfast'
      expect(@squat_record.valid?).to eq false
    end

    it "is invalid without lift_choice" do
      @squat_record.lift_choice = nil
      expect(@squat_record.valid?).to eq false
    end

    it "is invalid without weight if it has_weight" do
      @squat_record.weight = nil
      expect(@squat_record.valid?).to eq false
    end

    it 'is valid without weight if has_weight is false' do
      @squat.has_weight = false
      @squat_record.weight = nil
      expect(@squat_record.valid?).to eq true
    end

    it "is invalid with weight if has_weight is false" do
      @squat.has_weight = false
      @squat_record.weight = 70
      expect(@squat_record.valid?).to eq false
    end
  end

  describe "delegations" do
    it "returns the user" do
      expect(@squat_record.user).to eq @user
    end

    it "returns the has_weight" do
      expect(@squat_record.has_weight).to eq true
    end

    it "returns the has_weight?" do
      expect(@squat_record.has_weight?).to eq true
    end

    it "returns the name" do
      expect(@squat_record.name).to eq 'barbell squat'
    end

    it "returns the default sets" do
      expect(@squat_record.default_sets).to eq 3
    end

    it "returns the default reps" do
      expect(@squat_record.default_reps).to eq 5
    end
  end

  describe 'sets and reps' do
    it "uses the default sets when creating" do
        squat_record = @squat.lifts.create(
          occurred_date: Date.current,
          occurred_time: 'morning',
          weight: 70
        )
        expect(squat_record.sets).to eq 3
    end

    it "uses the default reps when creating" do
        squat_record = @squat.lifts.create(
          occurred_date: Date.current,
          occurred_time: 'morning',
          weight: 70
        )
        expect(squat_record.reps).to eq 5
    end
  end

end
