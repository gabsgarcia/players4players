class GamesController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @games = policy_scope(Game)
  end

  def show
    @game = Game.find(params[:id])
    @game_session = GameSession.new
  end

    private

  def verify_policy_scoped
    return true
  end
end
