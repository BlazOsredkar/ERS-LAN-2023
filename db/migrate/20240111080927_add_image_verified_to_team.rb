class AddImageVerifiedToTeam < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :image_verified, :boolean, default: false
  end
end
