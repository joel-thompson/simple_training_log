require 'rails_helper'

describe Barbell do

  describe 'validations' do
    it "isn't valid for negative weights" do
      plate = Plate.new(weight: -5)
      expect(plate.valid?).to eq false
    end

    it "isn't valid for weights not in the weight choices" do
      plate = Plate.new(weight: 57)
      expect(plate.valid?).to eq false
    end

    it "is valid for 25" do
      plate = Plate.new(weight: 25)
      expect(plate.valid?).to eq true
    end

    it "is valid with no input" do
      plate = Plate.new
      expect(plate.valid?).to eq true
    end
  end

  describe '.plate_choices' do
    it "returns the expected choices" do
      expect(Plate.choices).to eq [45.0, 35.0, 25.0, 10.0, 5.0, 2.5]
    end
  end
end
