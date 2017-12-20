class ChangeOccurredAtToBeDateInMartialArts < ActiveRecord::Migration[5.0]
  def change
    add_column :martial_arts, :occurred_date, :date
    add_column :martial_arts, :occurred_time, :string
  end
end
