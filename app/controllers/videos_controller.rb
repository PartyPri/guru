class VideosController < ApplicationController

  before_filter :check_valid_params, :check_valid_session, only: :get_upload_token

  def new
    unless user_signed_in? && !current_user.reels.empty?
      flash[:notice] = "You must be signed in and have at least 1 reel"
      redirect_to :root
    end
    @pre_upload_info = {}
    @video = Video.new
  end

  def create
    @video = Video.new(description: params[:video][:description], reel_id: params[:video][:reel_id])
    @reel = Reel.find(params[:video][:reel_id])

    if @reel.videos.length == 0
      @video.title = "#{@reel.name} - 1"
    else
      @video.title = "#{@reel.name} - #{@reel.videos.length + 1}"
    end

    if @video.save

      file = Yt::Account.new access_token: current_user.token
      file.upload_video params[:video][:file].try(:tempfile).try(:to_path), title: @video.title, description: @video.description, category: 'Entertainment'

      flash[:success] = 'Your video has been uploaded!'
      redirect_to @reel
    else
      flash[:error] = 'Something went wrong'
      render :new
    end
  end

  def youtube
    @video = Video.new
  end

  def create_youtube_video
    @video = Video.new(:uid => params[:uid], :description => params[:description], :reel_id => params[:video][:reel_id], :title => params[:title])
    if @video.save
      redirect_to :root
      flash[:success] = "Video successfully added!"
    else
      render 'new'
      flash[:error] = "Something went wrong"
    end
  end

  private

  #logout user if Google session is expired
  def check_valid_session
    unless current_user && !current_user.token_expired?
      sign_out(current_user)
      flash.keep[:notice]="Your session has expired."
      render :json => [], :status => :unauthorized 
    end
  end
end
