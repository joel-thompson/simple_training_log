class AddLocationToMartialArts < ActiveRecord::Migration[5.0]
  def change
    add_column :martial_arts, :location, :string
  end
end
