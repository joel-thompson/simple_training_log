require 'rails_helper'

RSpec.describe MartialArts::MartialArt, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # fixtures :martial_arts

  before do
    @sesh = MartialArts::MartialArt.new(
      notes: "had a great time",
      occurred_at: Time.zone.now
    )
  end

  describe "martial arts base class" do

    it "has correct friendly type" do
      expect(@sesh.friendly_type).to eq("Other")
    end

  end

end
