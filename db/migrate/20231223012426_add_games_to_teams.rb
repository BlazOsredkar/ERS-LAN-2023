class AddGamesToTeams < ActiveRecord::Migration[7.0]
  def change
    add_reference :teams, :game, foreign_key: true
  end
end
