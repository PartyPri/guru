class VideosUrlController < ApplicationController

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(:uid => params[:uid], :description => params[:description], :reel_id => params[:video][:reel_id])

    @reel = Reel.find(params[:video][:reel_id])
    @reel_name = @reel.name

    if Video.where(reel_id: @reel).blank?
      @video_id = 1 
    else
      @video_obj = Video.where(reel_id: @reel).last  
      @video_id = @video_obj.id - 1 
    end

    @video.title = "#{@reel_name} - #{@video_id}"

    if @video.save
      redirect_to :root
      flash[:success] = "Video successfully added!"
    else
      render 'new'
      flash[:error] = "Something went wrong"
    end
  end

end