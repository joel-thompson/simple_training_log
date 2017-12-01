class CreateMartialArts < ActiveRecord::Migration[5.0]
  def change
    create_table :martial_arts do |t|
      t.string :type
      t.datetime :occurred_at
      t.text :notes

      t.timestamps
    end
  end
end
