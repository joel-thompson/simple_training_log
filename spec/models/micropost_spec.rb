require 'rails_helper'

RSpec.describe Micropost, type: :model do

  fixtures :users
  fixtures :microposts

  before do
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")

    @joel = users(:joel)
  end

  describe "micropost" do

    it "should be valid" do
      expect(@micropost.valid?).to eq(true)
    end

    it "should have a user id" do
      @micropost.user_id = nil
      expect(@micropost.valid?).to eq(false)
    end

    it "should have content" do
      @micropost.content = "   "
      expect(@micropost.valid?).to eq(false)
    end

    it "should have content at max 140 characters" do
      @micropost.content = "a" * 141
      expect(@micropost.valid?).to eq(false)
    end

    it "should order by most recent first" do
      expect(Micropost.first).to eq(microposts(:most_recent))
    end

    it "should destroy associated microposts" do
      @joel.save
      @joel.microposts.create!(content: "Lorem ipsum")

      expect{
        @joel.destroy
      }.to change{Micropost.count}.by(-1)
    end

  end

end
