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

RSpec.describe MartialArts::MartialArt, type: :model do

  fixtures :users
  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  let(:user) { users(:martial_artist) }

  let(:badsesh) { martial_arts(:badsesh) }
  let(:sesh) { martial_arts(:sesh) }

  describe "martial arts base class" do

    it "has correct friendly type" do
      expect(sesh.friendly_type).to eq("Other")
    end

    it "is valid" do
      expect(sesh.valid?).to eq(true)
    end

    it "requires a user" do
      expect(badsesh.valid?).to eq(false)
    end

    it "is destroyed with the user" do
      number_of_records = user.martial_arts.count
      expect{
        user.destroy
      }.to change{MartialArts::MartialArt.count}.by(-number_of_records)
    end

    describe "validation" do

      it "doesn't have a goal_result without a goal" do
        badsesh.goal_result = "foo"
        expect(badsesh.valid?).to eq false
      end

      it "is valid with a goal and a goal result" do
        sesh.goal = "foo"
        sesh.goal_result = "bar"
        expect(sesh.valid?).to eq true
      end

      it "checks for bad times" do
        badsesh.occurred_time = "foo"
        expect(badsesh.valid?).to eq false
      end
    end
  end
end
