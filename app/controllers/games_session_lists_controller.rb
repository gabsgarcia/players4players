class GamesSessionListsController < ApplicationController
  # def index
  #   @games_session_lists = GamesSessionLists.all
  # end

  # def available
  #   @games_session_list.update(subscribe: !@games_session_list.subscribe)
  #   redirect_to games_session_list_path(@games_session_list)
  # end

  # def new
  #   @games_session_list = GamesSessionList.new
  # end

  # def create
  #   @games_session_list.user = current_user
  #   @games_session_list = GamesSessionList.new(games_session_list_params)
  #   if @games_session_list.save
  #     redirect_to game_session_path(@game_session)
  #   else
  #     render "new"
  #   end
  # end

  # private

  # def games_session_list_params
  #   params.require(:games_session_list).permit(:subscribe, :user_id, :games_session_id)
  # end

end
