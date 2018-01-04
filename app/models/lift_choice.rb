class LiftChoice < ApplicationRecord
  belongs_to :user
  has_many :lifts, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :has_weight, inclusion: [true, false]

  validates :name, uniqueness: { case_sensitive: false, scope: :user_id,
    message: "should be unique per user" }

  before_save :downcase_name


  def friendly_name
    name.split.map(&:capitalize).join(' ')
  end

  def last_occurred
    most_recent_date = lifts.order({ occurred_date: :asc }).last.occurred_date
    options = lifts.where(occurred_date: most_recent_date).to_a.flatten
    Entries.sort_by_occurred!(options).first
  end


  private def downcase_name
    self.name = name.downcase
  end

end
