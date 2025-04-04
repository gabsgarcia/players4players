class AddDetailsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :developer, :string
    add_column :games, :publisher, :string
    add_column :games, :release_date, :string
    add_column :games, :game_url, :string
    add_column :games, :freetogame_profile_url, :string
  end
end
