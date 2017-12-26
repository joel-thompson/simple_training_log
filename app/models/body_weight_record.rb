class BodyWeightRecord < ApplicationRecord



  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :weight, presence: true

  self.per_page = 20
  def self.page_length
    self.per_page
  end

end
