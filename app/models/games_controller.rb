class GamesController < ApplicationRecord
  belongs_to :platform
  belongs_to :game_session

  validates :name, :type, presence: true
end
