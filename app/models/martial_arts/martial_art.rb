# == Schema Information
#
# Table name: martial_arts
#
#  id                  :integer          not null, primary key
#  duration_in_seconds :integer
#  goal                :text
#  goal_result         :text
#  location            :string
#  notes               :text
#  occurred_date       :date
#  occurred_time       :string
#  type                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#
# Indexes
#
#  index_martial_arts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
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

    auto_strip_attributes :location, :goal, :goal_result, :notes

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
