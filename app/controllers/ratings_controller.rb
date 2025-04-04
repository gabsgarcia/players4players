class RatingsController < ApplicationController
  before_action :set_game
  before_action :check_existing_rating, only: [:create]

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    @rating.game = @game

    # Add Pundit authorization
    authorize @rating

    if @rating.save
      redirect_to game_path(@game), notice: "Thank you for rating this game!"
    else
      redirect_to game_path(@game), alert: "There was a problem with your rating: #{@rating.errors.full_messages.join(', ')}"
    end
  end

  private

  def set_game
    @game = Game.find_by(id: params[:game_id])
    redirect_to games_path, alert: "Game not found" unless @game
  end

  def check_existing_rating
    if Rating.exists?(user: current_user, game: @game)
      redirect_to game_path(@game), alert: "You've already rated this game."
      return
    end
  end

  def rating_params
    params.require(:rating).permit(:score, :comment)
  end
end
