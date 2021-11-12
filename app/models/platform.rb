class Platform < ApplicationRecord
  has_many :games
  has_many :games_controllers

  validates :name, presence: true
  validates :name, uniqueness: true
end
