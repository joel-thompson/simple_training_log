require 'rails_helper'

RSpec.describe MartialArts::MartialArt, type: :model do
  
    fixtures :users

  before do
    @user       = users(:michael)
    @other_user = users(:archer)
    @sesh = @user.martial_arts.new(
      notes: "had a great time",
      occurred_at: Time.zone.now
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

  end

end
