class VideosController < ApplicationController

  before_filter :check_valid_params, :check_valid_session, only: :get_upload_token

  def new
    unless user_signed_in? && !current_user.reels.empty?
      flash[:notice] = "You must be signed in and have at least 1 reel"
      redirect_to :root
    end
    @pre_upload_info = {}
    @video = Video.new
    @milestone_options = [[' Eureka', 'eureka', 'fa-lightbulb-o'], [' Mission Accomplished', 'mission_accomplished', 'fa-flag-checkered'], [' Challenge', 'challenge', 'fa-exclamation-triangle'], [' Victory', 'victory', 'fa-trophy'], [' Done', 'done', 'fa-check-square'], [' Experiment', 'experiment', 'fa-flask'], [' Lesson Learned', 'lesson_learned', 'fa-bookmark'] ]
  end

  def create
    check_valid_session and return

    account = Yt::Account.new access_token: current_user.token
    youtube_error_flash_message = 'Evrystep uses YouTube channels to handle videos. <a href="https://www.youtube.com/signin?next=/create_channel" target="_blank">Click here</a> to turn your channel on, and then try your upload again. You will only have to do this once'.html_safe

    begin
      account.channel
    rescue Yt::Errors::NoItems
      flash[:error] = youtube_error_flash_message
      render :new
      return
    end

    if !account.channel.try(:public?)
      flash[:error] = youtube_error_flash_message
      render :new
      return
    end

    @reel = Reel.find(params[:video][:reel_id])
    @video = Video.new(description: params[:video][:description], reel_id: params[:video][:reel_id], milestone: params[:video][:milestone])

    if @video.save
      @video.title = "#{@reel.name} - #{@reel.videos.length}"

      file = account.upload_video params[:video][:file].try(:tempfile).try(:to_path), privacy_status: :unlisted, title: @video.title, description: @video.description, category: 'Entertainment'
      @video.uid = file.id
      @video.save!

      # flash[:success] = 'Your video has been uploaded!'
      # redirect_to @reel

      render json: { message: "success", fileID: @video.id }, :status => 200
    else
      # flash[:error] = 'Something went wrong'
      # render :new
      
      render json: { error: @video.errors.full_messages.join(',')}, :status => 400
    end
  end

  def youtube
    @video = Video.new
  end

  def create_youtube_video
    @video = Video.new(:uid => params[:uid], :description => params[:description], :reel_id => params[:video][:reel_id], :title => params[:title], :milestone => params[:milestone])
    @reel = Reel.find(params[:video][:reel_id])
    if @video.save
      # redirect_to @reel
      # flash[:success] = "Video successfully added!"

      # send success header
      render json: { message: "success", fileID: @video.uid }, :status => 200
    else
      # render 'youtube'
      # flash[:error] = "Uh oh, something went wrong."

      #  need an error header, otherwise Dropzone will not interpret the response as an error:
      render json: { error: @video.errors.full_messages.join(',')}, :status => 400
    end
  end

  def upvote
    @video = Video.find(params[:id])
    @video.upvote_by current_user

    if request.xhr?
      render json: { count: @video.score, id: params[:id] }
    else
      redirect_to current_user
    end
  end

  private

  #logout user if Google session is expired
  def check_valid_session
    unless current_user && !current_user.token_expired?
      sign_out(current_user)
      flash.keep[:notice]="Your session has expired."
      redirect_to :root
      return true
    end
  end
end
