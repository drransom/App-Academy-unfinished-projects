class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :update
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render :show
    else
      render :update
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    index
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
