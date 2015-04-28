class GoalsController < ApplicationController
  before_action :view_permitted, only: [:show]
  before_action :modify_allowed, only: [:edit, :update, :destroy]
  
  def new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def complete
    @goal = Goal.find(params[:id])
    @goal.update(completed_on: Date.today)
    redirect_to user_url(@goal.user)
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end

  def goal_params
    params.require(:goal).permit(:user_id, :content, :private)
  end

  private
  def view_permitted
    @goal = Goal.find(params[:id])
    if @goal.private && current_user != @goal.user
      redirect_to user_url(current_user)
    end
  end

  def modify_allowed
    @goal = Goal.find(params[:id])
    if current_user != @goal.user
      redirect_to user_url(current_user)
    end
  end

end
