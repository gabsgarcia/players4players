class CreateGamesListGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games_list_games do |t|
      t.references :games_list, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
