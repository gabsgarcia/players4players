class GameSessionsController < ApplicationController
<<<<<<< HEAD
   before_action :verify_policy_scoped, only: %i[edit update]

  def edit
    @game_session = GameSession.find(params[:id])
  end

  def update
=======
before_action :set_session, only: [ :show, :edit, :destroy ]

  def index
    @game_sessions = GameSession.all
  end

  def show

  end

  def new
    @game_session = GameSession.new
    @games = Game.all
  end

  def create
    @game_session = GameSession.new(game_session_params)
    @chatroom = Chatroom.create!
    @game_session.user = current_user
    @game_session.chatroom = @chatroom

    if @game_session.save
      redirect_to game_session_path(@game_session)
    else
      render "new"
    end
  end

  def destroy
>>>>>>> 679c29448134e35e42203ddc4c2c0e458a5d2923

  end

  private

<<<<<<< HEAD
  def verify_policy_scoped
    self.user_id == current_user.id
  end
=======
  def set_game_session
    @game_session = GameSession.find(params[:id])
  end

  def game_session_params
    params.require(:game_session).permit(:date, :time, :description, :game_id)
  end

>>>>>>> 679c29448134e35e42203ddc4c2c0e458a5d2923
end
