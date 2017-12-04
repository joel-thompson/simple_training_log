class Technique < ApplicationRecord
  belongs_to :martial_art

  delegate :type, to: :martial_art

  validates :martial_art, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :details, length: { maximum: 1000 }
  validates :notes, length: { maximum: 1000 }

end
