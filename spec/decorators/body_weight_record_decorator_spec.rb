require 'rails_helper'

RSpec.describe BodyWeightRecordDecorator do

  fixtures :body_weight_records

  let(:record) { body_weight_records(:one_hour_ago) }

  describe '.weighed_at_text' do
    it "writes out the time of the weigh in" do
      decorated_record = record.decorate
      expect(decorated_record.weighed_at_text).to eq "About 1 hour ago -"
    end
  end

  context '.weight_text' do
    it "writes out the weight" do
      decorated_record = record.decorate
      expect(decorated_record.weight_text).to eq "<p>3.0</p>"
    end
  end
end
