class RemoveGameFromGamesLists < ActiveRecord::Migration[6.0]
  def change
    remove_column :games_lists, :game_id
  end
end
