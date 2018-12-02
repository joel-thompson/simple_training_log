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

class FunctionalThresholdPowerRecord < ApplicationRecord
  include StateOfTheNation

  belongs_to :user

  validates :watts, :recorded_at, presence: true

  considered_active.from(:recorded_at).until(:expired_at)

  self.per_page = 20
  def self.page_length
    self.per_page
  end
end
