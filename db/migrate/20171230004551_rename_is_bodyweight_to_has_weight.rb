class RenameIsBodyweightToHasWeight < ActiveRecord::Migration[5.0]
  def change
    rename_column :lift_choices, :is_bodyweight, :has_weight
  end
end
