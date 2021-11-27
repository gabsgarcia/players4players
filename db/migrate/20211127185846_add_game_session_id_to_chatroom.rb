class AddGameSessionIdToChatroom < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :game_session, foreign_key: true

  end
end
