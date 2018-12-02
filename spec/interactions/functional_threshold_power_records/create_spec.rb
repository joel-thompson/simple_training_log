require 'rails_helper'

module FunctionalThresholdPowerRecords
  describe Create do

    fixtures :users

    before { Timecop.freeze(Time.now) }

    let(:user) { users(:michael) }
    let(:record) { user.functional_threshold_power_records.create(watts: 55, recorded_at: Time.now - 1.month) }

    it "expires and adds a new record" do
      allow(user).to receive(:active_functional_threshold_power_record).and_return(record)
      expect(record).to receive(:update!).with(expired_at: Time.now).and_call_original
      expect(user).to receive_message_chain(:functional_threshold_power_records, :create!).with(
        watts: 50,
        recorded_at: Time.now,
      )

      FunctionalThresholdPowerRecords::Create.run!(user: user, watts: 50)
    end
  end
end
