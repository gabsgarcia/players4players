class GamesListsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :set_games_list, only: %i[show edit update destroy]

  def index
    @games_lists = policy_scope(GamesList).order(created_at: :desc)
    @games_lists = GamesList.where(user: current_user)
  end

  def home
    authorize @games_lists
  end

  def show

  end

  def my_games_lists
    @games_lists = games_list.where(user: current_user)
  end

  def new
    @games_list = GamesList.new
    authorize @games_list
  end

  def create
    @games_list = GamesList.new(games_list_params)
    authorize @games_list
    @games_list.user = current_user
    if @games_list.save
      redirect_to games_list_path(@games_list)
    else
      render "new"
    end
  end

  def destroy
    if @games_list.destroy
      redirect_to games_lists_path
    else
      render "destroy"
    end
  end

  def update
    @games_list.update(games_list_params)
    redirect_to games_list_path(@games_list)
  end

  def edit
  end

  private

  def games_list_params
    params.require(:games_list).permit(:name, :category, :photo, :user_id,
      game_ids: [],
      games_list_games_attributes: [:id, :game_ids, :games_list_id, :_destroy,
      game_atributes: [:id, :name]])
  end

  def set_games_list
    @games_list = GamesList.find(params[:id])
    authorize @games_list
  end
end
