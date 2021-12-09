class GamesSessionList < ApplicationRecord
  belongs_to :user
  belongs_to :games_session

  validates :name, :type, presence: true
end
