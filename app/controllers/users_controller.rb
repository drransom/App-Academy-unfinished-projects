class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)

    if user.save
        render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    begin
      user = User.find(params[:id])
    rescue
      render(
        json: 'user not found'
      )
    else
      render json: user
    end
  end

  def update
    user = User.find(params[:id])
    if user
      user.update(user_params)
      render text: "successfully updated user!"
    else
      render text: "failed to update user!"
    end
  end

  def destroy
    user = User.find(params[:id])
    if user
      User.destroy(params[:id])
      render text: "successfully destroyed user!"
    else
      render text: "failed to destroy user!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
