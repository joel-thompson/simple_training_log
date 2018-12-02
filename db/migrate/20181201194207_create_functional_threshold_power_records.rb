class CreateFunctionalThresholdPowerRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :functional_threshold_power_records do |t|
      t.float :watts
      t.datetime :recorded_at
      t.datetime :expired_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
