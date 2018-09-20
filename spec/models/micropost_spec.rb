# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  picture    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

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
