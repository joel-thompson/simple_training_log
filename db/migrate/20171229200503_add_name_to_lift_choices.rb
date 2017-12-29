class AddNameToLiftChoices < ActiveRecord::Migration[5.0]
  def change
    add_column :lift_choices, :name, :string
    add_index :lift_choices, :name
  end
end
