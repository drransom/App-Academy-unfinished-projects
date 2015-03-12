class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(email: params[:user][:email], password: params[:user][:password])
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    @user = User.where(id: params[:id]).take
    if @user
      render :show
    else
      render :root
    end
  end
end
