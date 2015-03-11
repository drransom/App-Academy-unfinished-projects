class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      login_user!(user)
    else
      flash.now[:error] = "Invalid username/password combination"
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end
end
