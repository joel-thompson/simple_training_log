module Entries

  ENTRIES_TIME_OPTIONS_FRIENDLY = ['Morning', 'Afternoon', 'Evening'].freeze
  ENTRIES_TIME_OPTIONS = ['morning', 'afternoon', 'evening'].freeze

  def self.times
    array = []
    ENTRIES_TIME_OPTIONS_FRIENDLY.zip(ENTRIES_TIME_OPTIONS).each do |a, b|
      array << [a,b]
    end
  end

  def self.valid_times
    ENTRIES_TIME_OPTIONS
  end

  def self.sort_by_occurred!(entries)
    entries.sort_by! { |e| e.created_at }
    entries.sort_by! { |e| ENTRIES_TIME_OPTIONS.index(e.occurred_time) }
    entries.sort_by! { |e| e.occurred_date }.reverse!

    entries
  end

  def self.time_now
    now = Time.now
    afternoon = Time.parse('12pm')
    evening = Time.parse('5pm')

    if now < afternoon
      ENTRIES_TIME_OPTIONS[0]
    elsif now >= afternoon && now < evening
      ENTRIES_TIME_OPTIONS[1]
    elsif now >= evening
      ENTRIES_TIME_OPTIONS[2]
    else
      ENTRIES_TIME_OPTIONS[0]
    end
  end

end
