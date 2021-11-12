class Game < ApplicationRecord
  belongs_to :platform

  validates :name, :summary, :category, presence: true
  validates :name, length: { minimum: 10 }
  validates :name, uniqueness: true
end
