class Chatroom < ApplicationRecord
  has_one :game_session
  has_many :messages
end
