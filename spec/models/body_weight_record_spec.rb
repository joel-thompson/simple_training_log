# == Schema Information
#
# Table name: body_weight_records
#
#  id         :integer          not null, primary key
#  weight     :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe BodyWeightRecord, type: :model do

  fixtures :users
  fixtures :body_weight_records

  before do
    @user       = users(:michael)
    @other_user = users(:archer)
    @record = @user.body_weight_records.new(weight: 66.6)
  end

  describe "validations" do
    it "has a user" do
      expect(@record.valid?).to eq true
    end

    it "has a weight value" do
      expect(@record.valid?).to eq true
    end
  end

  describe "ordering" do
    it "should order by most recent first" do
      expect(BodyWeightRecord.first).to eq(body_weight_records(:most_recent))
    end
  end

end
