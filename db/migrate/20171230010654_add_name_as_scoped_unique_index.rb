class AddNameAsScopedUniqueIndex < ActiveRecord::Migration[5.0]
  def change
    add_column :lift_choices, :name, :string
    add_index :lift_choices, [:user_id, :name], unique: true
  end
end
