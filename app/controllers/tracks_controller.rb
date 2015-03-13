class TracksController < ApplicationController
  before_action :require_user!
  def new
    render :new
  end

  def create
    @track = Track.new(album_params)
    if @track.save
      redirect_to album_url(@track)
    else
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    if @track
      render :show
    else
      flash[:errors] = "track not found"
      redirect_to user_url(current_user)
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to band_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy if @track
    redirect_to user_url(current_user)
  end

  private

  def track_params
    params.require(:track).permit(:name, :bonus, :album_id, :name, :lyrics)
  end
end
