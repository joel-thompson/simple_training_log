class RemoveOccurredFromBodyWeightRecords < ActiveRecord::Migration[5.0]
  def change
    remove_column :body_weight_records, :occurred_date, :date
    remove_column :body_weight_records, :occurred_time, :string
  end
end
