class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user.nil?
      flash.now[:errors] = "incorrect username and/or password"
      render :new
    else
      log_in!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    @user = User.find_by_session_token(session[:session_token])
    log_out!(@user)
    render :new
  end
end
