Time::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%A, %B #{time.day.ordinalize} %Y") }
Time::DATE_FORMATS[:short_date] = "%m-%d-%Y"
