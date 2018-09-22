# == Schema Information
#
# Table name: lifts
#
#  id             :integer          not null, primary key
#  last_amrap_set :integer
#  location       :string
#  notes          :text
#  occurred_date  :date
#  occurred_time  :string
#  reps           :integer
#  sets           :integer
#  weight         :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lift_choice_id :integer
#
# Indexes
#
#  index_lifts_on_lift_choice_id  (lift_choice_id)
#
# Foreign Keys
#
#  fk_rails_...  (lift_choice_id => lift_choices.id)
#

require 'rails_helper'

RSpec.describe Lift, type: :model do

  fixtures :users, :lift_choices, :lifts

  let(:user) { users(:weight_lifter) }

  let(:squat) { lift_choices(:squat) }
  let(:squat_record) { lifts(:squat) }

  describe "validations" do
    it "is valid when all info is present" do
      expect(squat_record.valid?).to eq true
    end

    it "is invalid without occurred_date" do
      squat_record.occurred_date = nil
      expect(squat_record.valid?).to eq false
    end

    it "is invalid without occurred_time" do
      squat_record.occurred_time = nil
      expect(squat_record.valid?).to eq false
    end

    it "is invalid without a valid occurred_time" do
      squat_record.occurred_time = 'after breakfast'
      expect(squat_record.valid?).to eq false
    end

    it "is invalid without lift_choice" do
      squat_record.lift_choice = nil
      expect(squat_record.valid?).to eq false
    end

    it "is invalid without weight if it has_weight" do
      squat_record.weight = nil
      expect(squat_record.valid?).to eq false
    end

    it 'is valid without weight if has_weight is false' do
      squat.has_weight = false
      squat_record.weight = nil
      expect(squat_record.reload.valid?).to eq true
    end

    it "is invalid with weight if has_weight is false" do
      squat.update(has_weight: false)
      expect(squat_record.reload.valid?).to eq false
    end
  end

  describe "delegations" do
    it "returns the user" do
      expect(squat_record.user).to eq user
    end

    it "returns the has_weight" do
      expect(squat_record.has_weight).to eq true
    end

    it "returns the has_weight?" do
      expect(squat_record.has_weight?).to eq true
    end

    it "returns the name" do
      expect(squat_record.name).to eq 'squat'
    end

    it "returns the default sets" do
      expect(squat_record.default_sets).to eq 3
    end

    it "returns the default reps" do
      expect(squat_record.default_reps).to eq 5
    end
  end

  describe 'sets and reps' do
    it "uses the default sets when creating" do
        squat_record = squat.lifts.create(
          occurred_date: Date.current,
          occurred_time: 'morning',
          weight: 70
        )
        expect(squat_record.sets).to eq 3
    end

    it "uses the default reps when creating" do
        squat_record = squat.lifts.create(
          occurred_date: Date.current,
          occurred_time: 'morning',
          weight: 70
        )
        expect(squat_record.reps).to eq 5
    end
  end

end
