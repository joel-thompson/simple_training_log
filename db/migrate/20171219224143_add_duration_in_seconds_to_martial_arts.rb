class AddDurationInSecondsToMartialArts < ActiveRecord::Migration[5.0]
  def change
    add_column :martial_arts, :duration_in_seconds, :integer
  end
end
