module MartialArts
  class MartialArt < ApplicationRecord
    before_save :default_values

    has_many :rounds
    has_many :techniques

    def friendly_name
      return "Martial Art" if type == nil
      type.split('::')[1].underscore.split('_').collect{|c| c.capitalize}.join(' ')
    end

    private def default_values
      self.occurred_at = Time.zone.now if self.occurred_at == nil
    end

  end
end
