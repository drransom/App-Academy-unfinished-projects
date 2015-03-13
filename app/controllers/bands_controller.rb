class BandsController < ApplicationController
  before_action :require_user!

  def new
    render :new
  end

  def create
    @band = Band.new(name: params[:band][:name])
    if @band.save
      redirect_to band_url(@band)
    else
      render :new
    end
  end

  def show(band = nil)
    band ||= Band.where(id: params[:id]).take
    @band = band
    if @band
      render :show
    else
      flash[:errors] = "band not found"
      redirect_to user_url(current_user)
    end
  end

  def edit
    @band = Band.find(params[:band])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy if @band
    redirect_to user_url(current_user)
  end

  def index
    @bands = Band.all
    render :index
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
