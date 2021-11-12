class GameSession < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :games_controllers

  validates :name, :date, :time, :description, presence: true
end
