require 'rails_helper'

describe Users::AddDefaultLiftChoices do

  fixtures :users

  before do
    @user = users(:michael)
    @other_user = users(:joel)
  end

  describe "when adding to an empty user" do

    it "adds barbell squat" do
      Users::AddDefaultLiftChoices.run!(user: @user)
      choice_names = @user.lift_choices.map { |lc| lc.name.downcase }

      expect(choice_names.include?('barbell squat')).to eq true
    end

    it "adds barbell deadlift" do
      Users::AddDefaultLiftChoices.run!(user: @user)
      choice_names = @user.lift_choices.map { |lc| lc.name.downcase }

      expect(choice_names.include?('barbell deadlift')).to eq true
    end

    it "adds barbell bench press" do
      Users::AddDefaultLiftChoices.run!(user: @user)
      choice_names = @user.lift_choices.map { |lc| lc.name.downcase }

      expect(choice_names.include?('barbell bench press')).to eq true
    end

    it "doesn't overwrite existing choices" do
      @other_user.lift_choices.create(
        name: 'barbell bench press',
        has_weight: true,
        default_sets: 2,
        default_reps: 2
      )
      Users::AddDefaultLiftChoices.run!(user: @user)

      bench = @other_user.reload.lift_choices.find_by(name: 'barbell bench press')

      expect(bench.default_sets).to eq 2
      expect(bench.default_reps).to eq 2
    end

  end

end
