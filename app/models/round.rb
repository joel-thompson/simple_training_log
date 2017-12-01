class Round < ApplicationRecord
  belongs_to :martial_art

  delegate :type, to: :martial_art

  validates :martial_art, presence: true
  validates :partner_name, length: { maximum: 50 }
  validates :notes, length: { maximum: 1000 }

end
