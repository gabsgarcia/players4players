class GamesListGame < ApplicationRecord
  belongs_to :games_list
  belongs_to :game

  accepts_nested_attributes_for :game, reject_if: :all_blank, allow_destroy: true
end
