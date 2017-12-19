module MartialArts
  class MartialArt < ApplicationRecord

    before_save :default_values

    has_many :rounds, dependent: :destroy
    has_many :techniques, dependent: :destroy

    belongs_to :user

    validates :user, presence: true

    def friendly_type
      return "Other" if type == nil
      type.split('::')[1].underscore.split('_').collect{|c| c.capitalize}.join(' ')
    end

    private def default_values
      self.occurred_at = Time.zone.now unless self.occurred_at.present?
      self.duration_in_seconds = 0 unless self.duration_in_seconds.present?
    end

  end
end
