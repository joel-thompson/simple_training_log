# == Schema Information
#
# Table name: cardios
#
#  id                  :integer          not null, primary key
#  cardio_choice_id    :integer
#  duration_in_seconds :integer
#  notes               :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  occurred_date       :date
#  occurred_time       :string
#

require 'rails_helper'

RSpec.describe Cardio, type: :model do
  fixtures :users

  before do
    @user = users(:michael)
    @run_choice = @user.cardio_choices.create(
      name: 'run'
    )
    @run_record = @run_choice.cardios.create(
      occurred_date: Date.current,
      occurred_time: 'morning',
      duration_in_seconds: 70
    )
  end

  describe 'validations' do
    it "is valid with all the details" do
      expect(@run_record.valid?).to eq true
    end

    it "is invalid without occurred date" do
      @run_record.occurred_date = nil
      expect(@run_record.valid?).to eq false
    end

    it "is invalid without occurred time" do
      @run_record.occurred_time = nil
      expect(@run_record.valid?).to eq false
    end
  end

  describe 'delegations' do
    it "returns the user" do
      expect(@run_record.user).to eq @user
    end

    it "returns the name" do
      expect(@run_record.name).to eq 'run'
    end

    it "returns the friendly_name" do
      expect(@run_record.friendly_name).to eq 'Run'
    end
  end

end
