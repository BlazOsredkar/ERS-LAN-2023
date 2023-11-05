class CreateTeamGames < ActiveRecord::Migration[7.0]
  def change
    create_table :team_games do |t|
      t.references :team, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
