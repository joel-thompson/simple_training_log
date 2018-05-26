class CreateCardios < ActiveRecord::Migration[5.0]
  def change
    create_table :cardios do |t|
      t.references :cardio_choice, foreign_key: true
      t.integer :duration_in_seconds
      t.text :notes

      t.timestamps
    end
  end
end
