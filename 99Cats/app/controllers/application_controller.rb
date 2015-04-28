class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :login_user!, :current_login,
                :other_logged_in_machines, :current_location

  def current_user
    return nil if (session[:session_token].nil? || current_login.nil?)
    @current_user ||= current_login.user
  end

  def login_user!(user)
    login = Login.new(
                      user_id: user.id,
                      ip_address: request.remote_ip,
                      machine_type: request.env["HTTP_USER_AGENT"])
    login.reset_session_token!
    login.save
    session[:session_token] = login.session_token
    redirect_to cats_url
  end

  def current_login
    @current_login ||= Login.find_by_session_token(session[:session_token])
  end

  def other_logged_in_machines
    current_login.other_logins.map { |login| login.machine_type }.join("\n")
  end

  def current_location
    "lat: #{current_login.latitude}, long: #{current_login.longitude}"
  end

end
