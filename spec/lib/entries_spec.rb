require 'rails_helper'

describe Entries do

  fixtures :users

  before do
    @options_friendly = ['Morning', 'Afternoon', 'Evening']
    @options = ['morning', 'afternoon', 'evening']
    @times = []
    @options_friendly.zip(@options).each do |a, b|
      @times << [a,b]
    end
    @user = users(:michael)
  end

  it "gives the right time options" do
    expect(Entries.times).to eq @times
  end

  describe "#sort_by_occurred!" do

    it "correcly sorts by occurred_date when time is the same" do
      first = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-6"),
        occurred_time: 'morning',
        duration_in_seconds: 60
      )
      second = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-4"),
        occurred_time: 'morning',
        duration_in_seconds: 60
      )
      entries = [second, first]
      Entries.sort_by_occurred!(entries)

      expect(entries.first).to eq first
      expect(entries.second).to eq second
    end

    it "correctly sorts by occurred_date when time different" do
      first = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-6"),
        occurred_time: 'morning',
        duration_in_seconds: 60
      )
      second = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-4"),
        occurred_time: 'evening',
        duration_in_seconds: 60
      )
      entries = [second, first]
      Entries.sort_by_occurred!(entries)

      expect(entries.first).to eq first
      expect(entries.second).to eq second
    end

    it "correctly sorts by occurred_time when date is the same" do
      first = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-6"),
        occurred_time: 'evening',
        duration_in_seconds: 60
      )
      second = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-6"),
        occurred_time: 'morning',
        duration_in_seconds: 60
      )
      entries = [second, first]
      Entries.sort_by_occurred!(entries)

      expect(entries.first).to eq first
      expect(entries.second).to eq second
    end

    it "correctly sorts by created_at when date and time is the same" do
      second = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-6"),
        occurred_time: 'morning',
        duration_in_seconds: 60
      )
      first = @user.martial_arts.create(
        occurred_date: Date.parse("2017-5-6"),
        occurred_time: 'morning',
        duration_in_seconds: 60
      )
      entries = [second, first]
      Entries.sort_by_occurred!(entries)

      expect(entries.first).to eq first
      expect(entries.second).to eq second
    end



  end

end
