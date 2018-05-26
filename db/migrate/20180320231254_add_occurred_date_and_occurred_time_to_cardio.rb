class AddOccurredDateAndOccurredTimeToCardio < ActiveRecord::Migration[5.0]
  def change
    add_column :cardios, :occurred_date, :date
    add_column :cardios, :occurred_time, :string
  end
end
