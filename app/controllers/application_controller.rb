class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo])
  end

  def dispatch_user
    return unless current_user && request.get?

    path = new_profile_path unless current_user.valid?
    path = dashboards_path if request.path == root.path
    redirect_to path unless path.nil? || path == request.path
  end
end
