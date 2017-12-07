require 'rails_helper'

RSpec.describe Technique, type: :model do

  fixtures :users
  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  before do
    @joel = users(:joel)
    @bjj = martial_arts(:jiu_jitsu)
    @bjj.user = @joel

    @triangle = @bjj.techniques.build(
      name: "triangle",
      details: "do the thing where i win",
      notes: "I have long legs so it works well"
    )

    @bad_tech = Technique.new
  end

  describe "techniques" do

    it "should be valid" do
      expect(@triangle.valid?).to eq(true)
    end

    it "does not validate without martial art" do
      expect(@bad_tech.valid?).to eq(false)
    end

    it "has a name" do
      @triangle.name = ""
      expect(@triangle.valid?).to eq(false)
    end

    it "should not have a long name" do
      @triangle.name = "a" * 51
      expect(@triangle.valid?).to eql(false)
    end

    it "should not have a long detail" do
      @triangle.details = "a" * 1001
      expect(@triangle.valid?).to eql(false)
    end

    it "should not have a long notes" do
      @triangle.notes = "a" * 1001
      expect(@triangle.valid?).to eql(false)
    end

    it "should be destroyed with user" do
      @bjj.save
      expect{
        @bjj.destroy
      }.to change{Technique.count}.by(-1)
    end

  end

end
