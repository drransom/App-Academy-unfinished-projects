class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: :error_saving_user
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render json: @user.errors.full_messages, status: :user_not_found
    end
  end

  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: :error_updating_user
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      User.destroy(@user.id)
      render json: @user
    else
      render json: @user.errors.full_messages, status: :error_deleting_user
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
