module MartialArts
  class MartialArt < ApplicationRecord

    before_save :default_values

    has_many :rounds, dependent: :destroy
    has_many :techniques, dependent: :destroy

    belongs_to :user

    validates :user, presence: true
    validate :valid_occurred_time

    def friendly_type
      return "Other" if type == nil
      type.split('::')[1].underscore.split('_').collect{|c| c.capitalize}.join(' ')
    end

    private def valid_occurred_time
      return unless self.occurred_time.present?
      errors.add(:occurred_time, "invalid time") unless Entries.valid_times.include? self.occurred_time
    end

    # might want to be more mindful about these - would be easy to allow all bad input
    private def default_values
      self.duration_in_seconds = 0 unless self.duration_in_seconds.present?
      self.occurred_date = Date.today unless self.occurred_date.present?
      self.occurred_time = "morning" unless self.occurred_time.present?
    end

  end
end
