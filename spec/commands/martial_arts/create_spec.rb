require 'rails_helper'

describe MartialArts::Create do

  fixtures :users

  before do
    @user = users(:michael)
    @sesh = @user.martial_arts.build(type: "MartialArts::JiuJitsu")
  end

  it "creates" do
    expect(MartialArts::MartialArt).to receive(:new).and_return(@sesh)
    expect(@sesh).to receive(:save).and_return(true)
    outcome = MartialArts::Create.run(
      user: @user,
      type: "MartialArts::JiuJitsu"
    )
    expect(outcome.result).to eq(@sesh)
    expect(outcome.success?).to eq(true)
  end

  it "fails without a type" do
    outcome = MartialArts::Create.run
    expect(outcome.success?).to eq(false)
    expect(outcome.result).to eq(nil)
  end

  it "fails with an invalid type" do
    outcome = MartialArts::Create.run(
      type: "5 Finger Ki Blast Practice"
    )
    expect(outcome.success?).to eq(false)
    expect(outcome.result).to eq(nil)
  end

end
