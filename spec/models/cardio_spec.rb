# == Schema Information
#
# Table name: cardios
#
#  id                  :integer          not null, primary key
#  duration_in_seconds :integer
#  notes               :text
#  occurred_date       :date
#  occurred_time       :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  cardio_choice_id    :integer
#
# Indexes
#
#  index_cardios_on_cardio_choice_id  (cardio_choice_id)
#
# Foreign Keys
#
#  fk_rails_...  (cardio_choice_id => cardio_choices.id)
#

require 'rails_helper'

RSpec.describe Cardio, type: :model do
  fixtures :users, :cardio_choices, :cardios

  let(:user) { users(:cardio_user) }
  let(:run_record) { cardios(:run) }

  describe 'validations' do
    it "is valid with all the details" do
      expect(run_record.valid?).to eq true
    end

    it "is invalid without occurred date" do
      run_record.occurred_date = nil
      expect(run_record.valid?).to eq false
    end

    it "is invalid without occurred time" do
      run_record.occurred_time = nil
      expect(run_record.valid?).to eq false
    end
  end

  describe 'delegations' do
    it "returns the user" do
      expect(run_record.user).to eq user
    end

    it "returns the name" do
      expect(run_record.name).to eq 'run'
    end

    it "returns the friendly_name" do
      expect(run_record.friendly_name).to eq 'Run'
    end
  end

end
