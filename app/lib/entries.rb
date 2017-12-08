module Entries

  ENTRIES_TIME_OPTIONS_FRIENDLY = ['Now', 'Morning', 'Afternoon', 'Evening'].freeze
  ENTRIES_TIME_OPTIONS = ['now', 'morning', 'afternoon', 'evening'].freeze

  def self.times
    array = []
    ENTRIES_TIME_OPTIONS_FRIENDLY.zip(ENTRIES_TIME_OPTIONS).each do |a, b|
      array << [a,b]
    end
  end

  def self.date_and_time_handler(date, time)
    time_now_string_array = Time.now.to_s.split(" ")

    date = time_now_string_array[0] if date == "" || date == nil

    if time == "" || time == nil || time == 'now'
      time = time_now_string_array[1]
    elsif time == "morning"
      time = "07:00:00"
    elsif time == "afternoon"
      time = "13:00:00"
    else
      time = "18:00:00"
    end

    time += " " + time_now_string_array[2]

    str = date + " " + time

    DateTime.parse(str).utc.to_s
  end

end
