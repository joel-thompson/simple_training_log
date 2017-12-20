class RemoveOccurredAtFromMartialArts < ActiveRecord::Migration[5.0]
  def change
    remove_column :martial_arts, :occurred_at, :datetime
  end
end
