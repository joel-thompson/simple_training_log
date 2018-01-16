class AddLastAmrapSetToLift < ActiveRecord::Migration[5.0]
  def change
    add_column :lifts, :last_amrap_set, :integer
  end
end
