# == Schema Information
#
# Table name: lift_choices
#
#  id           :integer          not null, primary key
#  default_reps :integer
#  default_sets :integer
#  has_weight   :boolean
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_lift_choices_on_user_id           (user_id)
#  index_lift_choices_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe LiftChoice, type: :model do

  fixtures :users, :lift_choices

  let(:user) { users(:weight_lifter) }
  let(:other_user) { users(:joel) }

  let(:squat) { lift_choices(:squat) }

  describe "validations" do
    it "is invalid without a name" do
      squat.name = nil
      expect(squat.valid?).to eq false
    end

    it "is valid with a name" do
      squat.name = "squat"
      expect(squat.valid?).to eq true
    end

    it "has a short name" do
      squat.name = 'a' * 51
      expect(squat.valid?).to eq false
    end

    it "has a unique name for each user" do
      user.lift_choices.create(
        name: 'deadlift',
        has_weight: false
      )
      deadlift = user.lift_choices.build(
        name: 'Deadlift',
        has_weight: false
      )
      expect(deadlift.valid?).to eq false
    end

    it "allows same name for multiple users" do
      other_user.lift_choices.create(
        name: 'deadlift1',
        has_weight: false
      )
      deadlift = user.lift_choices.build(
        name: 'deadlift1',
        has_weight: false
      )
      expect(deadlift.valid?).to eq true
    end

    it "has value for has_weight" do
      squat.has_weight = nil
      expect(squat.valid?).to eq false
    end
  end

  describe 'before save' do
    it "downcases the name" do
      kipping_pullup = user.lift_choices.create(
        has_weight: true,
        name: 'KIPPING PULLUP'
      )
      expect(kipping_pullup.name).to eq 'kipping pullup'
    end
  end

  describe "#friendly_name" do
    it "returns the nice name" do
      squat.name = "barbell squat"
      expect(squat.friendly_name).to eq "Barbell Squat"
    end
  end

  describe '#last_occurred' do
    it "returns the last occurred for the user and choice" do
      squat2 = user.lift_choices.create(
        name: 'squat2',
        has_weight: false
      )

      other_squat2 = other_user.lift_choices.create(
        name: 'other_squat2',
        has_weight: false
      )

      squat2.lifts.create(
        occurred_date: Date.current,
        occurred_time: 'morning',
        sets: 3,
        reps: 3
      )

      recent = squat2.lifts.create(
        occurred_date: Date.current,
        occurred_time: 'afternoon',
        sets: 3,
        reps: 3
      )

      other_squat2.lifts.create(
        occurred_date: Date.current,
        occurred_time: 'evening',
        sets: 3,
        reps: 3
      )

      expect(squat2.last_occurred).to eq recent
    end
  end

end
