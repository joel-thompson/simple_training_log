# == Schema Information
#
# Table name: training_programs
#
#  id             :integer          not null, primary key
#  activated_at   :datetime
#  deactivated_at :datetime
#  name           :string
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_training_programs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class TrainingProgram < ApplicationRecord
  belongs_to :user

  include StateOfTheNation
  considered_active.from(:activated_at).until(:deactivated_at)

  validates :name, presence: true, length: { maximum: 50 }
  validates :notes, presence: true, length: { maximum: 1000 }

  self.per_page = 9
  def self.page_length
    self.per_page
  end
end
