# == Schema Information
#
# Table name: techniques
#
#  id             :integer          not null, primary key
#  details        :text
#  name           :string
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  martial_art_id :integer
#
# Indexes
#
#  index_techniques_on_martial_art_id  (martial_art_id)
#
# Foreign Keys
#
#  fk_rails_...  (martial_art_id => martial_arts.id)
#

require 'rails_helper'

RSpec.describe Technique, type: :model do

  fixtures :users, :techniques, :martial_arts
  set_fixture_class 'martial_arts' => MartialArts::MartialArt

  let(:joel) { users(:martial_artist) }
  let(:bjj) { martial_arts(:jiu_jitsu) }

  let(:triangle) { techniques(:triangle) }
  let(:bad_tech) { techniques(:bad_tech) }

  describe "techniques" do

    it "should be valid" do
      expect(triangle.valid?).to eq(true)
    end

    it "does not validate without martial art" do
      expect(bad_tech.valid?).to eq(false)
    end

    it "has a name" do
      triangle.name = ""
      expect(triangle.valid?).to eq(false)
    end

    it "should not have a long name" do
      triangle.name = "a" * 51
      expect(triangle.valid?).to eql(false)
    end

    it "should not have a long detail" do
      triangle.details = "a" * 1001
      expect(triangle.valid?).to eql(false)
    end

    it "should not have a long notes" do
      triangle.notes = "a" * 1001
      expect(triangle.valid?).to eql(false)
    end

    it "should be destroyed with user" do
      tech_count = bjj.techniques.count
      expect{
        bjj.destroy
      }.to change{Technique.count}.by(-tech_count)
    end

  end

end
