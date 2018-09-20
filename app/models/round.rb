# == Schema Information
#
# Table name: rounds
#
#  id             :integer          not null, primary key
#  notes          :text
#  partner_name   :string
#  submissions    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  martial_art_id :integer
#
# Indexes
#
#  index_rounds_on_martial_art_id  (martial_art_id)
#
# Foreign Keys
#
#  fk_rails_...  (martial_art_id => martial_arts.id)
#

class Round < ApplicationRecord
  before_save :default_values

  belongs_to :martial_art, class_name: "MartialArts::MartialArt"

  delegate :type, to: :martial_art
  delegate :user, to: :martial_art

  validates :martial_art, presence: true
  validates :partner_name, presence: true, length: { maximum: 50 }
  validates :notes, length: { maximum: 1000 }

  auto_strip_attributes :notes

  private def default_values
    self.submissions = 0 unless self.submissions.present?
  end
end
