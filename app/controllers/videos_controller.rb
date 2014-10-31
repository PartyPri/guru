class VideosController < ApplicationController

  before_filter :check_valid_params, only: :get_upload_token

  def new
    unless user_signed_in? && !current_user.reels.empty?
      flash[:notice] = "You must be signed in and have at least 1 reel"
      redirect_to :root#error
    end
    @pre_upload_info = {}
    @video = Video.new
  end

  #Before uploading a video to YouTube, first send user's title, description, and category through the 
  #YouTube client and retrieve an upload token.
  def get_upload_token

    temp_params = { title: params[:title], description: params[:description], category: 'Entertainment',
                    keywords: [] }

    #save the reel on the session for use in get_video_uid
    session[:current_reel_id] = params[:video][:reel_id]
   
    if current_user
      youtube_client = YouTubeIt::OAuth2Client.new(client_access_token: current_user.token,
                                            dev_key: ENV['GOOGLE_APP_ID'])
   
      upload_info = youtube_client.upload_token(temp_params, get_video_uid_url)
   
      render json: {token: upload_info[:token], url: upload_info[:url]}
    else
      render json: {error_type: 'Not authorized.', status: :unprocessable_entity}
    end
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
    redirect_to current_user
end

  private

    #Check for upload params needed by the YouTube client and app video model
    def check_valid_params
      unless params[:title] !='' && params[:description] !='' && params[:video][:reel_id] 
        redirect_to({ :action=>'new' }, :notice => "Please fill out all form fields")
      end
    end

    def reel_params
      params.require(:video).permit(:reel_id)
    end
end
