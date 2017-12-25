class AddGoalAndGoalResultToMartialArts < ActiveRecord::Migration[5.0]
  def change
    add_column :martial_arts, :goal, :text
    add_column :martial_arts, :goal_result, :text
  end
end
