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

  let(:record) { body_weight_records(:most_recent) }

  describe "validations" do
    it "is valid" do
      expect(record.valid?).to eq true
    end
  end
end
