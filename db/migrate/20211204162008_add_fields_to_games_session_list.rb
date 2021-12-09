class AddFieldsToGamesSessionList < ActiveRecord::Migration[6.0]
  def change
    add_reference :games_session_lists, :game_session, foreign_key: true
  end
end
