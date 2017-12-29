class RemoveNameFromLiftChoicesAgain < ActiveRecord::Migration[5.0]
  def change
    remove_column :lift_choices, :name, :string
  end
end
