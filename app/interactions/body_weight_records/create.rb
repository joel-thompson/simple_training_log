module BodyWeightRecords
  class Create < ActiveInteraction::Base

    float :weight
    object :user, class: User

    time :at, default: nil

    def execute
      expire_current_weight if user.active_body_weight_record
      add_new_weight
    end

    private def expire_current_weight
      user.active_body_weight_record.update!(expired_at: now)
    end

    private def add_new_weight
      user.body_weight_records.create!(
        weight: weight,
        weighed_at: now,
      )
    end

    private def now
      @now ||= (at || Time.now)
    end

  end
end
