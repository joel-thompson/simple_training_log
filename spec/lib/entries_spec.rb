require 'rails_helper'

describe MartialArts do

  before do
    @options_friendly = ['Morning', 'Afternoon', 'Evening']
    @options = ['morning', 'afternoon', 'evening']
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

  describe "#get_occurred_string" do
    it "returns the evening string correctly" do
      zone = Time.now.to_s.split(" ")[2]
      control = ['2017-6-5', "18:00:00", zone].join(' ')
      occurred_at = DateTime.parse(control)

      result = Entries.get_occurred_string(occurred_at)
      expect(result).to eq('evening')
    end
  end

  it "returns the afternoon string correctly" do
    zone = Time.now.to_s.split(" ")[2]
    control = ['2017-6-5', "13:00:00", zone].join(' ')
    occurred_at = DateTime.parse(control)

    result = Entries.get_occurred_string(occurred_at)
    expect(result).to eq('afternoon')
  end

  it "returns the morning string correctly" do
    zone = Time.now.to_s.split(" ")[2]
    control = ['2017-6-5', "07:00:00", zone].join(' ')
    occurred_at = DateTime.parse(control)

    result = Entries.get_occurred_string(occurred_at)
    expect(result).to eq('morning')
  end

end
