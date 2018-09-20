# == Schema Information
#
# Table name: body_weight_records
#
#  id         :integer          not null, primary key
#  expired_at :datetime
#  weighed_at :datetime
#  weight     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_body_weight_records_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe BodyWeightRecord, type: :model do

  fixtures :users
  fixtures :body_weight_records

  before do
    @user       = users(:michael)
    @other_user = users(:archer)
    @record = @user.body_weight_records.new(weight: 66.6, weighed_at: Time.now)
  end

  describe "validations" do
    it "is valid" do
      expect(@record.valid?).to eq true
    end
  end

  describe "ordering" do
    it "should order by most recent first" do
      expect(BodyWeightRecord.first).to eq(body_weight_records(:most_recent))
    end
  end

end
