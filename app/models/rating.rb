class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :game_id, message: "You've already rated this game" }
end
