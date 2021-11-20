class GameSession < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :games_controllers
  belongs_to :chatroom

  validates :date, :time, :description, presence: true
end
