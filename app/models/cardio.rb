# == Schema Information
#
# Table name: cardios
#
#  id                  :integer          not null, primary key
#  cardio_choice_id    :integer
#  duration_in_seconds :integer
#  notes               :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  occurred_date       :date
#  occurred_time       :string
#

class Cardio < ApplicationRecord
  belongs_to :cardio_choice

  validates :occurred_date, presence: true
  validates :occurred_time, presence: true
  validate :valid_occurred_time

  delegate :user, :name, :friendly_name, to: :cardio_choice

  def duration_in_minutes
    return nil unless duration_in_seconds.present?
    duration_in_seconds / 60
  end
end
