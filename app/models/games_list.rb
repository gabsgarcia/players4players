class GamesList < ApplicationRecord
  belongs_to :user
  has_many :games_list_games, dependent: :destroy
  has_many :games, through: :games_list_games

  accepts_nested_attributes_for :games_list_games, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :games, reject_if: :all_blank, allow_destroy: true

  has_one_attached :photo
end
