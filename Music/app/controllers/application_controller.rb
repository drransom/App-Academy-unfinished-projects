class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :log_in!, :log_out!, :logged_in?, :current_user

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    current_user ? true : false
  end

  def require_user!
    unless logged_in?
      flash[:errors] = "You must log in first."
      redirect_to new_sessions_url
    end
  end
end
