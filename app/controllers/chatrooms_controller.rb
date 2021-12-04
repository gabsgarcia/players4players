class ChatroomsController < ApplicationController
  before_action :set_game_session, only: %i[new create]

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

  def index
    @chatrooms = policy_scope(Chatroom)
  end

  def new
    @chatroom = Chatroom.new
    @chatroom.game_session = @game_session
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.game_session = @game_session
    @chatroom.name = @game_session.game.name + ' ' + @game_session.id.to_s
    if @chatroom.save
      redirect_to chatroom_path(@chatroom)
    else
      render :new
    end
  end

  private

  def set_game_session
    @game_session = GameSession.find(params[:game_session_id])
  end
end
