class GameSession < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :games_controllers
  has_many :games_session_list
  has_one :chatroom, dependent: :destroy

  validates :date, :time, :description, presence: true
end
