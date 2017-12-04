require 'rails_helper'

describe MartialArts::Create do

  before do
    @sesh = MartialArts::JiuJitsu.new
  end

  it "creates" do
    expect(MartialArts::MartialArt).to receive(:new).and_return(@sesh)
    expect(@sesh).to receive(:save).and_return(true)
    outcome = MartialArts::Create.run(
      friendly_type: "Jiu Jitsu"
    )
    expect(outcome.result).to eq(@sesh)
    expect(outcome.success?).to eq(true)
  end

  it "fails without a friendly_type" do
    outcome = MartialArts::Create.run
    expect(outcome.success?).to eq(false)
    expect(outcome.result).to eq(nil)
  end

  it "fails with an invalid friendly_type" do
    outcome = MartialArts::Create.run(
      friendly_type: "5 Finger Ki Blast Practice"
    )
    expect(outcome.success?).to eq(false)
    expect(outcome.result).to eq(nil)    
  end

end
