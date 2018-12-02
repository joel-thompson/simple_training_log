# == Schema Information
#
# Table name: functional_threshold_power_records
#
#  id          :integer          not null, primary key
#  expired_at  :datetime
#  recorded_at :datetime
#  watts       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_functional_threshold_power_records_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe FunctionalThresholdPowerRecord, type: :model do
  fixtures :users
  fixtures :functional_threshold_power_records

  let(:record) { functional_threshold_power_records(:most_recent) }

  describe "validations" do
    it "is valid" do
      expect(record.valid?).to eq true
    end
  end
end
