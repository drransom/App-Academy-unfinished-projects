class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    unless current_user
      flash[:error] = "You must be logged in to add a new cat!"
      redirect_to new_session_url
      return
    end

    @cat.user_id = current_user.id
    if @cat.save
      render :show
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    if @cat.user == current_user
      render :update
    else
      flash[:error] = "You do not own this cat!"
      redirect_to cat_url(@cat)
    end
  end

  def update
    @cat = Cat.find(params[:id])
    redirect_to cat_url(@cat) unless @cat.user == current_user
    if @cat.update_attributes(cat_params)
      render :show
    else
      render :update
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    if @cat.user == current_user
      @cat.destroy
      index
    else
      flash[:error] = "You do not own this cat!"
      redirect_to cat_url(@cat)
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :sex, :description, :birth_date, :color, :name)
  end
end
