# == Schema Information
#
# Table name: martial_arts
#
#  id                  :integer          not null, primary key
#  duration_in_seconds :integer
#  goal                :text
#  goal_result         :text
#  location            :string
#  notes               :text
#  occurred_date       :date
#  occurred_time       :string
#  type                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#
# Indexes
#
#  index_martial_arts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

module MartialArts
  class JiuJitsu < MartialArts::MartialArt


    def rolls
      rounds
    end

  end
end
