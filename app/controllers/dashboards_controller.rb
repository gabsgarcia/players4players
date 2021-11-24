class DashboardsController < ApplicationController
  before_action :verify_policy_scoped, only: :index

  def index
    @games = Game.all
    authorize @games
  end

  private

  def verify_policy_scoped
    return true
  end
end
