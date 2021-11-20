class Game < ApplicationRecord
  belongs_to :platform
  has_many :games_list

  validates :name, :summary, :category, presence: true
  validates :name, length: { minimum: 10 }
  validates :name, uniqueness: true
end
