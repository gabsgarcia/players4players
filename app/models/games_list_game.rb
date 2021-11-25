class GamesListGame < ApplicationRecord
  belongs_to :games_list
  belongs_to :game
end
