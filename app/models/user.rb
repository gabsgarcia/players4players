class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :games_lists, dependent: :destroy
  has_many :game_sessions, dependent: :destroy
  has_many :messages
  has_many :games_session_lists, dependent: :destroy

  validates :first_name, :last_name, :nickname, :age, presence: true, on: :update
end
