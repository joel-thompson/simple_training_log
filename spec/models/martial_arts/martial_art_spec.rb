require 'rails_helper'
require 'spec_helper'

RSpec.describe MartialArts::MartialArt, type: :model do

  fixtures :users

  before do
    @user       = users(:michael)
    @other_user = users(:archer)
    @sesh = @user.martial_arts.new(
      notes: "had a great time",
      duration_in_seconds: 60
    )

    @badsesh = MartialArts::MartialArt.new
  end

  describe "martial arts base class" do

    it "has correct friendly type" do
      expect(@sesh.friendly_type).to eq("Other")
    end

    it "is valid" do
      expect(@sesh.valid?).to eq(true)
    end

    it "requires a user" do
      expect(@badsesh.valid?).to eq(false)
    end

    it "is destroyed with the user" do
      @user.save
      expect{
        @user.destroy
      }.to change{MartialArts::MartialArt.count}.by(-1)
    end

    describe "validation" do

      it "doesn't have a goal_result without a goal" do
        @badsesh.goal_result = "foo"
        expect(@badsesh.valid?).to eq false
      end

      it "is valid with a goal and a goal result" do
        @sesh.goal = "foo"
        @sesh.goal_result = "bar"
        expect(@sesh.valid?).to eq true
      end

      it "checks for bad times" do
        @badsesh.occurred_time = "foo"
        expect(@badsesh.valid?).to eq false
      end

    end

    describe "when finding the most recent occurred" do
      it "returns the most recent occurred entry" do
        # binding.pry
        @user.martial_arts.create(
          duration_in_seconds: 60,
          occurred_date: Date.yesterday,
          occurred_time: 'morning'
        )
        @user.martial_arts.create(
          duration_in_seconds: 60,
          occurred_date: Date.today,
          occurred_time: 'morning'
        )
        b = @user.martial_arts.create(
          duration_in_seconds: 60,
          occurred_date: Date.today,
          occurred_time: 'afternoon'
        )
        expect(MartialArts::MartialArt.last_occurred).to eq b
      end
    end

  end



end
