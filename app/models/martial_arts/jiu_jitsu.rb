# == Schema Information
#
# Table name: martial_arts
#
#  id                  :integer          not null, primary key
#  type                :string
#  notes               :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  duration_in_seconds :integer
#  occurred_date       :date
#  occurred_time       :string
#  goal                :text
#  goal_result         :text
#  location            :string
#

module MartialArts
  class JiuJitsu < MartialArts::MartialArt


    def rolls
      rounds
    end

  end
end
