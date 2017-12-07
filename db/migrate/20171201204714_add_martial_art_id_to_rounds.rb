class AddMartialArtIdToRounds < ActiveRecord::Migration[5.0]
  def change
    add_reference :rounds, :martial_art, foreign_key: true
  end
end
