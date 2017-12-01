class Round < ApplicationRecord
  belongs_to :martial_art

  delegate :type, to: :martial_art

  validates :martial_art, presence: true

end
