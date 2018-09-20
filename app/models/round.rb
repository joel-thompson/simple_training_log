# == Schema Information
#
# Table name: rounds
#
#  id             :integer          not null, primary key
#  partner_name   :string
#  submissions    :integer
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  martial_art_id :integer
#

class Round < ApplicationRecord
  before_save :default_values

  belongs_to :martial_art, class_name: "MartialArts::MartialArt"

  delegate :type, to: :martial_art
  delegate :user, to: :martial_art

  validates :martial_art, presence: true
  validates :partner_name, presence: true, length: { maximum: 50 }
  validates :notes, length: { maximum: 1000 }

  private def default_values
    self.submissions = 0 unless self.submissions.present?
  end
end
