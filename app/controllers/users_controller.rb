class UsersController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
  end

  # def index
  #   @users = User.all
  #   render :index
  # end
  #
  # def show
  #   @user = User.find(params[:id])
  #   render :show
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
    else
      flash[:error] = "invalid username or password"
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
