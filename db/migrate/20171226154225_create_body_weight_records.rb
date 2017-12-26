class CreateBodyWeightRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :body_weight_records do |t|
      t.float :weight
      t.date :occurred_date
      t.string :occurred_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
