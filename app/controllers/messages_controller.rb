class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to game_session_path(@chatroom.game_session_id)
    else
      render "chatrooms/show"
    end
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
end
