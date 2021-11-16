class Chatroom < ApplicationRecord
  belongs_to :user
  has_many :message
end
