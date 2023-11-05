class CreateGamesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :description
      t.string :link

      t.timestamps
    end
  end
end
