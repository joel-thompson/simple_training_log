require 'rails_helper'

RSpec.describe Round, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  before do
    @base = martial_arts(:base)
    @bjj = martial_arts(:jiu_jitsu)

    @roll = @bjj.rounds.build(
      partner_name: "chris",
      submissions: 3,
      notes: "hit a triangle"
    )

    @bad_round = Round.new
  end

  describe "rounds" do

    it "validates when there's a martial art" do
      expect(@roll.valid?).to eq(true)
    end

    it "does not validate if there's no martial art" do
      expect(@bad_round.valid?).to eq(false)
    end

    it "should not have a long partner name" do
      @roll.partner_name = "a" * 51
      expect(@roll.valid?).to eql(false)
    end

    it "should not have a long notes" do
      @roll.notes = "a" * 1001
      expect(@roll.valid?).to eql(false)
    end

  end

end
