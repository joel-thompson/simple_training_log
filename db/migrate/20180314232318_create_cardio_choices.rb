class CreateCardioChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :cardio_choices do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.index [:user_id, :name], unique: true

      t.timestamps
    end
  end
end
