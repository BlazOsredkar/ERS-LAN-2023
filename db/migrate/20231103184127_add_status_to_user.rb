class AddStatusToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :user_status, foreign_key: true
  end
end
