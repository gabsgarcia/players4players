class GamesController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:query].present?
      @games = Game.where("name ILIKE ?", "%#{params[:query]}%")
    elsif params[:category].present?
      # Use case-insensitive search for more reliable matching
      @games = Game.where("category ILIKE ?", "%#{params[:category]}%")

      # Add debugging to see what's going on
      puts "Searching for category: #{params[:category]}"
      puts "Found #{@games.count} games with this category"
    else
      # @games = policy_scope(Game)
      @games = Game.all
    end

    # Return JSON if format is JSON
    respond_to do |format|
      format.html
      format.json {
        puts "Returning #{@games.count} games in JSON format"
        render json: @games.select(:id, :name, :category)
      }
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
