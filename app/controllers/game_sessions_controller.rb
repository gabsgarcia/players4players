class GameSessionsController < ApplicationController
  before_action :set_game_session, only: %i[show edit destroy]

  def edit
    @game_session = GameSession.find(params[:id])
  end

  def update

  end

  def index
    @game_sessions = policy_scope(GameSession)
  end


  def show
    set_chatroom
    @message = Message.new
  end

  def new
    @game_session = GameSession.new
    authorize @game_session
  end

  def create
    @game_session = GameSession.new(game_session_params)
    @game_session.user = current_user
    authorize @game_session
    if @game_session.save
      # criar nova chatroom passando id game session
      @chatroom = Chatroom.new(game_session_id: @game_session.id, name: @game_session.game.name + ' ' + @game_session.id.to_s)
      @chatroom.save
      redirect_to game_session_path(@game_session)
    else
      render "new"
    end
  end

  def destroy
    if @game_session.destroy
      redirect_to game_sessions_path
    else
      render "destroy"
    end
  end


  private

  def set_chatroom
    @chatroom = Chatroom.find_by(game_session: @game_session.id)
  end

  def set_game_session
    @game_session = GameSession.find(params[:id])
    authorize @game_session
  end

  def game_session_params
    params.require(:game_session).permit(:date, :time, :description, :game_id)
  end
end
