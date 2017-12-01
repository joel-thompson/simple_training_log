class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.string :partner_name
      t.integer :submissions
      t.text :notes

      t.timestamps
    end
  end
end
