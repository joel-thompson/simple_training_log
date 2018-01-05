class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private def valid_occurred_time
    return unless self.occurred_time.present?
    errors.add(:occurred_time, "invalid time") unless Entries.valid_times.include? self.occurred_time
  end
  
end
