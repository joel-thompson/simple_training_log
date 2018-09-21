require 'rails_helper'

RSpec.describe UserDecorator do

  fixtures :users
  fixtures :body_weight_records

  let(:user) { users(:user_with_body_weight_records) }
  let(:user_without_records) { users(:archer) }

  describe '.thirty_day_weight_graph' do
    it "uses time.now for the last day" do
      decorated_user = user.decorate
      expect(decorated_user.thirty_day_weight_graph.last).to eq [Date.today, 40.0]
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
      expect(decorated_user.graph_max_weight).to eq 430
    end
  end

  describe '.graph_min_weight' do
    it "works" do
      decorated_user = user.decorate
      expect(decorated_user.graph_min_weight).to eq 0
    end
  end
end
