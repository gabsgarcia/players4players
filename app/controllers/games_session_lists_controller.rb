class GamesSessionListsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new available create destroy]

  def index
    @games_session_lists = GamesSessionList.where(user: current_user).order(name: :asc)
  end

  def new
    @games_session_list = GamesSessionList.new
  end

  def available
    if @games_session_list = nil
      render "new"
    else
      render "destroy"
    end
  end

  def create
    @game_session = GameSession.find(params:[:game_session_id])
    @games_session_list = GamesSessionList.create(game_session: @game_session, user: current_user)
    if @games_session_list.save
      redirect_to game_session_path(@game_session)
    else
      render "new"
    end
  end

  def destroy
    set_game_session_list
    if @games_session_list.destroy
      redirect_to game_session_path(@game_session)
    else
      render "destroy"
    end
  end

  private

  def set_game_session_list
    @game_session = GameSession.find(params:[:game_session_id])
    @games_session_list = GamesSessionList.find(game_session: @game_session, user: current_user)
  end

end
