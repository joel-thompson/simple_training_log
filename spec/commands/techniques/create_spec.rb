require 'rails_helper'

describe Techniques::Create do

  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  before do
    @sesh = martial_arts(:base)
    @technique = @sesh.techniques.build(name: "triangle")
  end

  it "creates" do
    expect(Technique).to receive(:new).and_return(@technique)
    expect(@technique).to receive(:save).and_return(true)
    outcome = Techniques::Create.run(
      martial_art: @sesh,
      name: "triangle"

    )
    expect(outcome.result).to eq(@technique)
    expect(outcome.success?).to eq(true)
  end

  it "fails without a martial art" do
    expect(Technique).to_not receive(:new)
    outcome = Techniques::Create.run(name: "triangle")
    expect(outcome.success?).to eq(false)
    expect(outcome.result).to eq(nil)
  end

  it "fails without a name" do
    expect(Technique).to_not receive(:new)
    outcome = Techniques::Create.run(martial_art: @sesh)
    expect(outcome.success?).to eq(false)
    expect(outcome.result).to eq(nil)
  end

end
