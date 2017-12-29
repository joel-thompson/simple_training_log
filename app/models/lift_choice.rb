class LiftChoice < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :has_weight, inclusion: [true, false]

  validates :name, uniqueness: { case_sensitive: false, scope: :user_id,
    message: "should be unique per user" }

  before_save :downcase_name


  def friendly_name
    name.split.map(&:capitalize).join(' ')
  end


  private def downcase_name
    self.name = name.downcase
  end

end
