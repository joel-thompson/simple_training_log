# == Schema Information
#
# Table name: techniques
#
#  id             :integer          not null, primary key
#  name           :string
#  details        :text
#  notes          :text
#  martial_art_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Technique < ApplicationRecord
  belongs_to :martial_art, class_name: "MartialArts::MartialArt"

  delegate :type, to: :martial_art
  delegate :user, to: :martial_art

  validates :martial_art, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :details, length: { maximum: 1000 }
  validates :notes, length: { maximum: 1000 }

  auto_strip_attributes :notes, :details

end
