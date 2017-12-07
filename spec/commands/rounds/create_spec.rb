require 'rails_helper'

describe Rounds::Create do

  fixtures :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  before do
    @sesh = martial_arts(:base)
    @round = @sesh.rounds.build
  end

  it "creates" do
    expect(Round).to receive(:new).and_return(@round)
    expect(@round).to receive(:save).and_return(true)
    outcome = Rounds::Create.run(
      martial_art: @sesh
    )
    expect(outcome.result).to eq(@round)
    expect(outcome.success?).to eq(true)
  end

  it "fails without a martial art" do
    expect(Round).to_not receive(:new)
    outcome = Rounds::Create.run
    expect(outcome.success?).to eq(false)
    expect(outcome.result).to eq(nil)
  end

end
