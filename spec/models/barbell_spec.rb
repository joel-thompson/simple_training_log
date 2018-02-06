require 'rails_helper'

describe Barbell do

  describe 'validations' do
    it "isn't valid with small weights" do
      barbell = Barbell.new(weight: 10)
      expect(barbell.valid?).to eq false
    end

    it "isn't valid with weights not divisible by the smallest plate" do
      barbell = Barbell.new(weight: 551)
      expect(barbell.valid?).to eq false
    end

    it "is valid with default weight" do
      barbell = Barbell.new
      expect(barbell.valid?).to eq true
    end
  end

  describe 'plate counts' do
    it "has the right plate counts when weight is 45" do
      barb = Barbell.new(weight: 45)
      expect(barb.plate_count(45)).to eq 0
      expect(barb.plate_count(35)).to eq 0
      expect(barb.plate_count(25)).to eq 0
      expect(barb.plate_count(10)).to eq 0
      expect(barb.plate_count(5)).to eq 0
      expect(barb.plate_count(2.5)).to eq 0
    end

    it "has the right plate counts when weight is 185" do
      barb = Barbell.new(weight: 185)
      expect(barb.plate_count(45)).to eq 1
      expect(barb.plate_count(35)).to eq 0
      expect(barb.plate_count(25)).to eq 1
      expect(barb.plate_count(10)).to eq 0
      expect(barb.plate_count(5)).to eq 0
      expect(barb.plate_count(2.5)).to eq 0
    end

    it "has the right plate counts when weight is 210" do
      barb = Barbell.new(weight: 210)
      expect(barb.plate_count(45)).to eq 1
      expect(barb.plate_count(35)).to eq 1
      expect(barb.plate_count(25)).to eq 0
      expect(barb.plate_count(10)).to eq 0
      expect(barb.plate_count(5)).to eq 0
      expect(barb.plate_count(2.5)).to eq 1
    end

    it "updates the plate counts after updating weight" do
      barb = Barbell.new(weight: 210)
      barb.weight = 45
      expect(barb.plate_count(45)).to eq 0
      expect(barb.plate_count(35)).to eq 0
      expect(barb.plate_count(25)).to eq 0
      expect(barb.plate_count(10)).to eq 0
      expect(barb.plate_count(5)).to eq 0
      expect(barb.plate_count(2.5)).to eq 0
    end

    it "returns nil for a plate count for a non exisitent plate" do
      barb = Barbell.new(weight: 210)
      expect(barb.plate_count(7)).to eq nil
    end

  end

end
