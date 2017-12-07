class AddUserToMartialArts < ActiveRecord::Migration[5.0]
  def change
    add_reference :martial_arts, :user, foreign_key: true
  end
end
