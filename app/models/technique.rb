# == Schema Information
#
# Table name: techniques
#
#  id             :integer          not null, primary key
#  details        :text
#  name           :string
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  martial_art_id :integer
#
# Indexes
#
#  index_techniques_on_martial_art_id  (martial_art_id)
#
# Foreign Keys
#
#  fk_rails_...  (martial_art_id => martial_arts.id)
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
