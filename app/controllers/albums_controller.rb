class AlbumsController < ApplicationController
  before_action :require_user!
  def new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def show
    @album = Album.where(id: params[:id]).take
    if @album
      render :show
    else
      flash[:errors] = "album not found"
      redirect_to user_url(current_user)
    end
  end

  def edit
    @album = Album.find(params[:album])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(band_params)
      redirect_to band_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy if @album
    redirect_to user_url(current_user)
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :name, :live)
  end

end
