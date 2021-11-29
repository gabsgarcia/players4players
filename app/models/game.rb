class Game < ApplicationRecord
  belongs_to :platform
  has_many :games_list_games
  has_many :games_list, through: :games_list_games

  accepts_nested_attributes_for :games_list_games, reject_if: :all_blank, allow_destroy: true

  validates :name, :summary, :category, presence: true
  validates :name, length: { minimum: 3 }
  validates :name, uniqueness: true
end
