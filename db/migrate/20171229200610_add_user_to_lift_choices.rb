class AddUserToLiftChoices < ActiveRecord::Migration[5.0]
  def change
    add_reference :lift_choices, :user, foreign_key: true
  end
end
