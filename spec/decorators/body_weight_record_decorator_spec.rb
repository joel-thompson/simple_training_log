require 'rails_helper'

RSpec.describe BodyWeightRecordDecorator do

  fixtures :users

  let(:user) { users(:michael) }
  let(:user_without_records) { users(:archer) }

  before do
    BodyWeightRecords::Update.run!(user: user, weight: 3, at: Time.now - 1.hour)
  end

  describe '.weighed_at_text' do
    it "writes out the time of the weigh in" do
      decorated_record = user.body_weight_records.first.decorate
      expect(decorated_record.weighed_at_text).to eq "About 1 hour ago -"
    end
  end

  context '.weight_text' do
    it "writes out the weight" do
      decorated_record = user.body_weight_records.first.decorate
      expect(decorated_record.weight_text).to eq "<p>3.0</p>"
    end
  end
end
