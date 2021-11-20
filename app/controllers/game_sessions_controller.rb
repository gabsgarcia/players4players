class GameSessionsController < ApplicationController
   before_action :verify_policy_scoped, only: %i[edit update]

  def edit
    @game_session = GameSession.find(params[:id])
  end

  def update

  end

  private

  def verify_policy_scoped
    self.user_id == current_user.id
  end
end
