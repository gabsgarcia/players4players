class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :games_lists, dependent: :destroy
  has_many :game_sessions, dependent: :destroy
  has_many :chatrooms
  has_many :messages

  validates :last_name, :first_name, :nickname, :age, presence: true
end
