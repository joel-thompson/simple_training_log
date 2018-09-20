# == Schema Information
#
# Table name: lift_choices
#
#  id           :integer          not null, primary key
#  default_sets :integer
#  default_reps :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  has_weight   :boolean
#  user_id      :integer
#  name         :string
#

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
    return nil if Lift.where(lift_choice: self).empty?
    most_recent_date = lifts.order({ occurred_date: :asc }).last.occurred_date
    options = lifts.where(occurred_date: most_recent_date).to_a.flatten
    Entries.sort_by_occurred!(options).first
  end


  private def downcase_name
    self.name = name.downcase
  end

end
