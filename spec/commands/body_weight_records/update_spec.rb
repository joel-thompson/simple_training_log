require 'rails_helper'

module BodyWeightRecords
  describe Update do

    fixtures :users

    before { Timecop.freeze(Time.now) }

    let(:user) { users(:michael) }
    let(:record) { user.body_weight_records.create(weight: 55, weighed_at: Time.now - 1.month) }

    it "expires and adds a new record" do
      allow(user).to receive(:active_body_weight_record).and_return(record)
      expect(record).to receive(:update!).with(expired_at: Time.now)
      expect(user).to receive_message_chain(:body_weight_records, :create!).with(
        weight: 50,
        weighed_at: Time.now,
      )

      BodyWeightRecords::Update.run!(user: user, weight: 50)
    end
  end
end
