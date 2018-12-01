require 'rails_helper'

RSpec.describe TrainingProgramDecorator do

  fixtures :users, :training_programs

  let(:program) { training_programs(:starting_strength) }

  context '.name_text' do
    it "capitalizes and formats" do
      expect(program.decorate.name_text).to eq "Starting_strength"
    end
  end

  context '.name_text_formatted' do
    it "capitalizes and formats" do
      expect(program.decorate.name_text_formatted).to eq "<p>Starting_strength</p>"
    end
  end

  context '.notes_text' do
    it "formats" do
      expect(program.decorate.notes_text).to eq "<p>do stuff</p>"
    end
  end

  context '.schedule_text' do
    it "formats" do
      expect(program.decorate.schedule_text).to eq "<p>monday: lift</p>"
    end
  end

end
