require 'rails_helper'

describe MartialArts do

  it "returns expected type for Jiu Jitsu" do
    type = MartialArts.get_type("Jiu Jitsu")
    expect(type).to eq("MartialArts::JiuJitsu")
  end

  it "returns nil for Other" do
    type = MartialArts.get_type("Other")
    expect(type).to eq(nil)
  end

  it "returns nil for an invalid" do
    type = MartialArts.get_type("5 Finger Ki Blast Practice")
    expect(type).to eq(nil)
  end

  it "returns the correct array of friendly_types" do
    friendly_types = ["Jiu Jitsu", "Other"]
    expect(MartialArts.available_friendly_types).to eq(friendly_types)
  end

  it "uses relative model naming" do
    expect(MartialArts.use_relative_model_naming?).to eq(true)
  end


end
