class AddNumberOfPlayersToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :number_of_players, :integer, default: 0
  end
end
