class CreateTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :techniques do |t|
      t.string :name
      t.text :details
      t.text :notes
      t.references :martial_art, foreign_key: true

      t.timestamps
    end
  end
end
