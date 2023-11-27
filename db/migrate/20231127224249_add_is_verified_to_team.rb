class AddIsVerifiedToTeam < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :is_verified, :boolean, default: false
  end
end
