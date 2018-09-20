# == Schema Information
#
# Table name: cardio_choices
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_cardio_choices_on_user_id           (user_id)
#  index_cardio_choices_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class CardioChoice < ApplicationRecord
  belongs_to :user
  has_many :cardios, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :name, uniqueness: { case_sensitive: false, scope: :user_id,
    message: "should be unique per user" }

  before_save :downcase_name

  def friendly_name
    name.split.map(&:capitalize).join(' ')
  end

  def last_occurred
    return nil if Cardio.where(cardio_choice: self).empty?
    most_recent_date = cardios.order({ occurred_date: :asc }).last.occurred_date
    options = cardios.where(occurred_date: most_recent_date).to_a.flatten
    Entries.sort_by_occurred!(options).first
  end

  private def downcase_name
    self.name = name.downcase
  end

end
