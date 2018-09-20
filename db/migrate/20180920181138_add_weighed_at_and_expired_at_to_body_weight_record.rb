class AddWeighedAtAndExpiredAtToBodyWeightRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :body_weight_records, :weighed_at, :datetime
    add_column :body_weight_records, :expired_at, :datetime
  end
end
