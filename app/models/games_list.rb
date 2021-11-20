class GamesList < ApplicationRecord
  belongs_to :user
  has_many :games_list_games
  has_many :games, through: :games_list_games

  has_one_attached :photo
end
