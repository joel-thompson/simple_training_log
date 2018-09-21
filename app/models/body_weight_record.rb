# == Schema Information
#
# Table name: body_weight_records
#
#  id         :integer          not null, primary key
#  expired_at :datetime
#  weighed_at :datetime
#  weight     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_body_weight_records_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class BodyWeightRecord < ApplicationRecord

  include StateOfTheNation

  belongs_to :user

  validates :weight, :weighed_at, presence: true

  considered_active.from(:weighed_at).until(:expired_at)

  self.per_page = 20
  def self.page_length
    self.per_page
  end

end
