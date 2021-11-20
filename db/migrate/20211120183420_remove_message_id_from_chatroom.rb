class RemoveMessageIdFromChatroom < ActiveRecord::Migration[6.0]
  def change
    remove_column :chatrooms, :message_id
  end
end
