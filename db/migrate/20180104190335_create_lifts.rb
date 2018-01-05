class CreateLifts < ActiveRecord::Migration[5.0]
  def change
    create_table :lifts do |t|
      t.references :lift_choice, foreign_key: true
      t.float :weight
      t.integer :sets
      t.integer :reps
      t.date :occurred_date
      t.string :occurred_time
      t.string :location
      t.text :notes

      t.timestamps
    end
  end
end
