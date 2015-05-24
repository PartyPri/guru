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

  #Before uploading a video to YouTube, first send user's title, description, and category through the 
  #YouTube client and retrieve an upload token.
  def get_upload_token

    @reel = Reel.find(params[:media][:reel_id])
    @reel_name = @reel.name

    if Video.where(reel_id: @reel).blank?
      @video_id = 1 
    else
      @video_obj = Video.where(reel_id: @reel).last  
      @video_id = @video_obj.id - 1 
    end

    temp_params = { title: "#{@reel_name} - #{@video_id}", description: params[:description], category: 'Entertainment', keywords: [] }


    #save the reel on the session for use in get_video_uid
    session[:current_reel_id] = params[:media][:reel_id]
    youtube_client = YouTubeIt::OAuth2Client.new(client_access_token: current_user.token,
                                          dev_key: ENV['GOOGLE_APP_ID'], 
                                          client_id: ENV['GOOGLE_CLIENT_ID'],
                                          client_secret: ENV["GOOGLE_CLIENT_SECRET"])
 
    upload_info = youtube_client.upload_token(temp_params, get_video_uid_url)  
    render json: {token: upload_info[:token], url: upload_info[:url]}
  end

  #The redirect URL the YouTube client posts to after a video upload. This function saves the video data into the app database.
  def get_video_uid
    video_uid = params[:id]
    v = Reel.find(session[:current_reel_id]).videos.build(uid: video_uid)
    youtube = YouTubeIt::OAuth2Client.new(dev_key: ENV['GOOGLE_DEV_KEY'])
    yt_video = youtube.video_by(video_uid)
    v.title = yt_video.title
    v.description = yt_video.description
    v.save
    flash[:notice] = 'Thanks for uploading your video!'
    redirect_to reel_path(session[:current_reel_id])
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

  #Check for upload params needed by the YouTube client and app video model
  def check_valid_params
    unless params[:title] !='' && params[:description] !='' && params[:media][:reel_id] 
      render json: {error_type: 'Missing params.', status: :unprocessable_entity}
    end
  end
end
