class AddIsBodyweightToLiftChoices < ActiveRecord::Migration[5.0]
  def change
    add_column :lift_choices, :is_bodyweight, :boolean
  end
end
