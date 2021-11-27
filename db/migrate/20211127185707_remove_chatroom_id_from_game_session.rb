class RemoveChatroomIdFromGameSession < ActiveRecord::Migration[6.0]
  def change
    remove_column :game_sessions, :chatroom_id
  end
end
