class Game < ApplicationRecord
  belongs_to :platform
  has_many :games_list_games
  has_many :games_list, through: :games_list_games
  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :games_list_games, reject_if: :all_blank, allow_destroy: true

  validates :name, :summary, :category, presence: true
  validates :name, length: { minimum: 3 }
  validates :name, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search_by_title,
                  against: :title,
                  using: { tsearch: { prefix: true } }

  def average_rating
    if ratings.any?
      ratings.average(:score).to_f.round(1)
    else
      0.0 # Return 0 when no ratings
    end
  end

  def rating_count
    ratings.count
  end

  def user_rating(user)
    ratings.find_by(user: user)
  end

  def rated_by?(user)
    ratings.exists?(user: user)
  end
end
