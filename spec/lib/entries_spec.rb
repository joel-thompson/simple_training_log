require 'rails_helper'

describe MartialArts do

  before do
    @options_friendly = ['Now', 'Morning', 'Afternoon', 'Evening']
    @options = ['now', 'morning', 'afternoon', 'evening']
    @times = []
    @options_friendly.zip(@options).each do |a, b|
      @times << [a,b]
    end
  end

  it "gives the right time options" do
    expect(Entries.times).to eq @times
  end

  it "properly handles date and time" do
    zone = Time.now.to_s.split(" ")[2]
    control = ['2017-6-5', "07:00:00", zone].join(' ')
    result_control = DateTime.parse(control).utc.to_s

    date = '2017-6-5'
    time = 'morning'
    result_lib = Entries.date_and_time_handler(date, time)

    expect(result_lib).to eq result_control
  end

end
