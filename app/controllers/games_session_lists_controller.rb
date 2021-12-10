class GamesSessionListsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new available create destroy]
  before_action :set_game_session, only: %i[available create]
  # def index
  #   @games_session_lists = GamesSessionList.where(user: current_user).order(name: :asc)
  # end

  # def new
  #   @games_session_list = GamesSessionList.new
  # end

  # def available
  #   @games_session_list.subscribe = true
  #   redirect_to games_session_path(@games_session_list.games_session)
  # end

  # def create
  #   @games_session_list = GamesSessionList.create(game_session: @game_session, user: current_user)
  #   if @games_session_list.save
  #     render "avaible"
  #   else
  #     render "new"
  #   end
  # end

  # def destroy
  #   set_games_session_list
  #   if @games_session_list.destroy
  #     redirect_to game_session_path(@game_session)
  #   else
  #     render "destroy"
  #   end
  # end

  # private

  # def set_games_session_list
  #   @games_session_list = GamesSessionList.find(params[:id])
  #   authorize @games_session_list
  # end

  # def find_games_session_list_by_game_session
  #   @games_session_list = GamesSessionList.find(game_session: @game_session, user: current_user)
  # end

  # def set_game_session
  #   @game_session = GameSession.find(params:[:game_session_id])
  #   authorize @game_session
  # end

end
