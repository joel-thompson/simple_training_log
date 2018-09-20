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

class Cardio < ApplicationRecord
  belongs_to :cardio_choice

  validates :occurred_date, presence: true
  validates :occurred_time, presence: true
  validate :valid_occurred_time

  delegate :user, :name, :friendly_name, to: :cardio_choice

  auto_strip_attributes :notes

  def duration_in_minutes
    return nil unless duration_in_seconds.present?
    duration_in_seconds / 60
  end
end
