class Game < ApplicationRecord
  belongs_to :platform
  has_many :games_list_games
  has_many :games_list, through: :games_list_games

  validates :name, :summary, :category, presence: true
  validates :name, length: { minimum: 3 }
  validates :name, uniqueness: true
end
