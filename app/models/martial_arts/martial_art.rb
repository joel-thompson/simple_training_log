module MartialArts
  class MartialArt < ApplicationRecord

    has_many :rounds
    has_many :techniques

    belongs_to :user

    validates :user, presence: true

    def friendly_type
      return "Other" if type == nil
      type.split('::')[1].underscore.split('_').collect{|c| c.capitalize}.join(' ')
    end

  end
end
