class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.requestor_id = current_user.id
    @cats = Cat.all
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat)
    else
      render :new
    end
  end

  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :update
  end

  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.update_attributes(cat_rental_request_params)
      render :show
    else
      render :update
    end
  end

  def destroy
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.destroy
    index
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.cat_owner == current_user
      @cat_rental_request.deny!
    else
      flash[:error] = "You do not own this cat!"
    end

    redirect_to cat_url(@cat_rental_request.cat)
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.cat_owner == current_user
      @cat_rental_request.approve!
    else
      flash[:error] = "You do not own this cat!"
    end

    redirect_to cat_url(@cat_rental_request.cat)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
