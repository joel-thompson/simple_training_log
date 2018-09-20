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
require 'spec_helper'

RSpec.describe MartialArts::MartialArt, type: :model do

  fixtures :users

  before do
    @user       = users(:michael)
    @other_user = users(:archer)
    @sesh = @user.martial_arts.new(
      notes: "had a great time",
      duration_in_seconds: 60,
      occurred_time: "morning",
      occurred_date: Date.current
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

  end



end
