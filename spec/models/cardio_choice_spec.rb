# == Schema Information
#
# Table name: cardio_choices
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_cardio_choices_on_user_id           (user_id)
#  index_cardio_choices_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe CardioChoice, type: :model do
  fixtures :users

  before do
    @user  = users(:michael)
    @other_user = users(:joel)
    @run = @user.cardio_choices.new
  end

  describe "validations" do
    it "is invalid without a name" do
      expect(@run.valid?).to eq false
    end

    it "is valid with a name" do
      @run.name = 'run'
      expect(@run.valid?).to eq true
    end

    it "has a short name" do
      @run.name = 'a' * 51
      expect(@run.valid?).to eq false
    end

    it "has a unique name for each user" do
      @user.cardio_choices.create(
        name: 'running'
      )
      running = @user.cardio_choices.build(
        name: 'Running'
      )
      expect(running.valid?).to eq false
    end

    it "allows the same name for different users" do
      @user.cardio_choices.create(
        name: 'running'
      )
      running = @other_user.cardio_choices.build(
        name: 'running'
      )
      expect(running.valid?).to eq true
    end
  end

  describe 'before save' do
    it "downcases the name" do
      @row_machine = @user.cardio_choices.create(
        name: 'ROW MACHINE'
      )
      expect(@row_machine.name).to eq 'row machine'
    end
  end

  describe "#friendly_name" do
    it "returns the nice name" do
      @run.name = "row machine"
      expect(@run.friendly_name).to eq "Row Machine"
    end
  end

  describe '#last_occurred' do
    it "returns the last occurred for the user and choice" do
      run = @user.cardio_choices.create(
        name: 'run'
      )

      other_run = @other_user.cardio_choices.create(
        name: 'run'
      )

      run.cardios.create(
        occurred_date: Date.current,
        occurred_time: 'morning'
      )

      recent = run.cardios.create(
        occurred_date: Date.current,
        occurred_time: 'afternoon'
      )

      other_run.cardios.create(
        occurred_date: Date.current,
        occurred_time: 'evening'
      )

      expect(run.last_occurred).to eq recent
    end
  end

end
