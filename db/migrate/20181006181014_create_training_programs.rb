class CreateTrainingPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :training_programs do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :notes

      t.datetime :activated_at
      t.datetime :deactivated_at

      t.timestamps
    end
  end
end
