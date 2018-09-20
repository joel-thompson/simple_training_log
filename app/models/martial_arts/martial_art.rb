# == Schema Information
#
# Table name: martial_arts
#
#  id                  :integer          not null, primary key
#  type                :string
#  notes               :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  duration_in_seconds :integer
#  occurred_date       :date
#  occurred_time       :string
#  goal                :text
#  goal_result         :text
#  location            :string
#

module MartialArts
  class MartialArt < ApplicationRecord

    has_many :rounds, dependent: :destroy
    has_many :techniques, dependent: :destroy

    belongs_to :user

    validates :user, presence: true
    validates :occurred_date, presence: true
    validates :occurred_time, presence: true

    validate :valid_occurred_time
    validate :valid_goal
    validate :valid_duration

    def friendly_type
      return "Other" if type == nil
      type.split('::')[1].underscore.split('_').collect{|c| c.capitalize}.join(' ')
    end

    def duration_in_minutes
      return nil unless duration_in_seconds.present?
      duration_in_seconds / 60
    end

    private def valid_goal
      if !self.goal.present? && self.goal_result.present?
        errors.add(:goal_result, "not valid without goal")
      end
    end

    private def valid_duration
      errors.add(:duration, "cannot be blank") unless self.duration_in_seconds.present?
    end

  end
end
