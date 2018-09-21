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

require 'rails_helper'

RSpec.describe Round, type: :model do

  fixtures :users, :rounds
  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  let(:joel) { users(:martial_artist) }
  let(:bjj) { martial_arts(:jiu_jitsu) }
  let(:roll) { rounds(:roll) }
  let(:bad_round) { rounds(:bad_round) }

  describe "rounds" do

    it "validates when there's a martial art" do
      expect(roll.valid?).to eq(true)
    end

    it "does not validate if there's no martial art" do
      expect(bad_round.valid?).to eq(false)
    end

    it "should not have a long partner name" do
      roll.partner_name = "a" * 51
      expect(roll.valid?).to eql(false)
    end

    it "should not have a long notes" do
      roll.notes = "a" * 1001
      expect(roll.valid?).to eql(false)
    end

    it "is destroyed with the martial art" do
      round_count = bjj.rounds.count
      expect{
        bjj.destroy
      }.to change{Round.count}.by(-round_count)
    end

  end

end
