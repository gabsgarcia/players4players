class ProfilesController < ApplicationController
  before_action :verify_policy_scoped, only: %i[edit update]

  def new
    @profile = current_user
  end

  def create
    @profile = current_user
    authorize current_user
    if @profile.update(user_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :age, :photo)
  end

  def verify_policy_scoped
    self.user_id == current_user.id
  end
end
