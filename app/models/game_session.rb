class GameSession < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :games_controllers
  has_one :chatroom

  validates :name, :date, :time, :description, presence: true
end
