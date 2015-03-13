class SessionsController < ApplicationController
  before_action :require_not_logged_in, only: [:new, :create]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name],
                                     params[:user][:password])

    if @user
      log_in!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = 'Invalid login'
      render :new
    end
  end

  def destroy
    @user = current_user
    log_out!
    redirect_to new_session_url
  end

  def require_not_logged_in
    redirect_to user_url(current_user) if current_user
  end
end
