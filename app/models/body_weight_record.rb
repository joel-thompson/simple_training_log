# == Schema Information
#
# Table name: body_weight_records
#
#  id         :integer          not null, primary key
#  weight     :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BodyWeightRecord < ApplicationRecord



  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :weight, presence: true

  self.per_page = 20
  def self.page_length
    self.per_page
  end

end
