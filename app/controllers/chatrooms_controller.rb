class ChatroomsController < ApplicationController

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def index
    @chatrooms = Chatroom.all
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    if @chatroom.save
      @chatroom.user = current_user
      redirect_to chatroom_path(@chatroom)
    else
      render :new
    end
  end
end
