class AddScheduleToTrainingPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :training_programs, :schedule, :text
  end
end
