class Chatroom < ApplicationRecord
  belongs_to :game_session
  has_many :messages, dependent: :destroy
end
