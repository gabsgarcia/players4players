class GamesController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:query].present?
      @games = Game.where("name ILIKE ?", "%#{params[:query]}%")
    else
      # @games = policy_scope(Game)
      @games = Game.all
    end
  end


  def show
    @game = Game.find(params[:id])
    authorize @game
    @game_session = GameSession.new
    authorize @game_session
  end

    private

  def verify_policy_scoped
    return true
  end
end
