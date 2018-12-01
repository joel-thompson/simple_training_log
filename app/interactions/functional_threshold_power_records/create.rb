module FunctionalThresholdPowerRecords
  class Create < ActiveInteraction::Base

    float :watts
    object :user, class: User

    time :at, default: nil

    def execute
      expire_current_record if user.active_functional_threshold_power_record
      add_new_record
    end

    private def expire_current_record
      user.active_functional_threshold_power_record.update!(expired_at: now)
    end

    private def add_new_record
      user.functional_threshold_power_records.create!(
        watts: watts,
        recorded_at: now,
      )
    end

    private def now
      @now ||= (at || Time.now)
    end

  end
end
