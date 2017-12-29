class CreateLiftChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :lift_choices do |t|
      t.string :name
      t.integer :default_sets
      t.integer :default_reps

      t.timestamps
    end
    add_index :lift_choices, :name, unique: true
  end
end
