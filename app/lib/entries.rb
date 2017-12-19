module Entries

  ENTRIES_TIME_OPTIONS_FRIENDLY = ['Morning', 'Afternoon', 'Evening'].freeze
  ENTRIES_TIME_OPTIONS = ['morning', 'afternoon', 'evening'].freeze

  MORNING = "07:00:00".freeze
  AFTERNOON = "13:00:00".freeze
  EVENING = "18:00:00".freeze

  def self.times
    array = []
    ENTRIES_TIME_OPTIONS_FRIENDLY.zip(ENTRIES_TIME_OPTIONS).each do |a, b|
      array << [a,b]
    end
  end

  def self.date_and_time_handler(date, time)
    time_now_string_array = Time.now.to_s.split(" ")

    date = time_now_string_array[0] if date == "" || date == nil

    if time == "morning"
      time = MORNING
    elsif time == "afternoon"
      time = AFTERNOON
    elsif time == "evening"
      time = EVENING
    else
      time = MORNING
    end

    time += " " + time_now_string_array[2]

    str = date + " " + time

    DateTime.parse(str).utc.to_s
  end

  def self.get_occurred_string(occurred_at)
    time_existing = occurred_at.localtime

    date_string_existing = occurred_at.localtime.to_s.split(" ")[0]

    # time_morning = Time.parse(date_string_existing + " " + MORNING)
    time_afternoon = Time.parse(date_string_existing + " " + AFTERNOON)
    time_evening = Time.parse(date_string_existing + " " + EVENING)

    if time_existing >= time_evening
      # eve
      "evening"
    elsif time_existing >= time_afternoon
      # aft
      "afternoon"
    else
      # morn
      "morning"
    end
  end

end
