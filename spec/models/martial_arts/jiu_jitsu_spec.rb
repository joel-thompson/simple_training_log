require 'rails_helper'

RSpec.describe MartialArts::JiuJitsu, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # fixtures :martial_arts

  before do
    @sesh = MartialArts::JiuJitsu.new(
      notes: "had a great time",
      occurred_at: Time.zone.now
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
