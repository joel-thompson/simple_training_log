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

require 'rails_helper'

RSpec.describe MartialArts::JiuJitsu, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # fixtures :martial_arts

  before do
    @sesh = MartialArts::JiuJitsu.new(
      notes: "had a great time"
    )
  end

  describe "jiu jitsu" do

    it "has correct friendly type" do
      expect(@sesh.friendly_type).to eq("Jiu Jitsu")
    end

    it "can call rolls" do
      expect(@sesh.rolls).to eq([])
    end

  end

end
