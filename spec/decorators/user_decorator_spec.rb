require 'rails_helper'

RSpec.describe UserDecorator do

  fixtures :users

  let(:user) { users(:michael) }
  let(:user_without_records) { users(:archer) }

  before do
    BodyWeightRecords::Update.run!(user: user, weight: 1, at: Date.today - 20.days)
    BodyWeightRecords::Update.run!(user: user, weight: 2, at: Date.today - 10.days)
    BodyWeightRecords::Update.run!(user: user, weight: 3, at: Time.now)
  end

  describe '.thirty_day_weight_graph' do
    it "uses time.now for the last day" do
      decorated_user = user.decorate
      expect(decorated_user.thirty_day_weight_graph.last).to eq [Date.today, 3.0]
    end
  end

  describe '.has_weight_records' do
    it "returns true when weight records are present" do
      decorated_user = user.decorate
      expect(decorated_user.has_weight_records?).to eq true
    end

    it "returns false when records are not present" do
      decorated_user = user_without_records.decorate
      expect(decorated_user.has_weight_records?).to eq false
    end
  end

  describe '.graph_max_weight' do
    it "works" do
      decorated_user = user.decorate
      expect(decorated_user.graph_max_weight).to eq 13
    end
  end

  describe '.graph_min_weight' do
    it "works" do
      decorated_user = user.decorate
      expect(decorated_user.graph_min_weight).to eq 0
    end
  end
end
