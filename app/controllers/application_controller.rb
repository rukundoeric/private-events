class ApplicationController < ActionController::Base
  def require_login
    redirect_to sign_in_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  helper_method :current_user
end
