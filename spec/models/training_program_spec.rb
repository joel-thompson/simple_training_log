# == Schema Information
#
# Table name: training_programs
#
#  id             :integer          not null, primary key
#  activated_at   :datetime
#  deactivated_at :datetime
#  name           :string
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_training_programs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe TrainingProgram, type: :model do
  fixtures :users, :training_programs

  let(:user) { users(:weight_lifter) }
  let(:program) { training_programs(:starting_strength) }
  let(:program_without_user) { training_programs(:program_without_user) }

  context 'validation' do
    it "is invalid without a user" do
      expect(program_without_user.valid?).to eq false
    end

    it "is valid with a user" do
      expect(program.valid?).to eq true
    end

    it "is invalid with a long name" do
      program.name = "a" * 51
      expect(program.valid?).to eq false
    end

    it "is invalid with a long notes" do
      program.notes = "a" * 1001
      expect(program.valid?).to eq false
    end

    it "is invalid without a name" do
      program.name = nil
      expect(program.valid?).to eq false
    end

    it "is invalid without notes" do
      program.notes = nil
      expect(program.valid?).to eq false
    end
  end
end
