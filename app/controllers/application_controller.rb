class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user, :user_signed_in?

  stale_when_importmap_changes

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to root_path, alert: "You need to sign in to access this page." unless user_signed_in?
  end
end
