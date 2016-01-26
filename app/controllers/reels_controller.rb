class ReelsController < ApplicationController
  before_filter :set_interests, only: [:new, :edit]

  NOT_FOUND_NOTICE = "Reel not found"

  impressionist :actions=>[:show]

  def index
    interest_id = params[:interest_id]

    if interest_id && interest = Interest.find(interest_id)
      reels = interest.reels
    else
      reels = Reel
    end

    tagged_reels = reels.tagged_with(params[:tag])

    if params[:user_id]
      tagged_reels = tagged_reels.by_user_id(params[:user_id].to_i)
    end

    render json: tagged_reels, include: { images: {methods: :photo}, videos: {}, stories: {} }
  end

  def show
    @reel = Reel.includes(:images, :videos, :user).find_by_id(params[:id])
    return redirect_with_error(NOT_FOUND_NOTICE) if @reel.nil?

    @images = @reel.images
    @videos = @reel.videos
    @user = @reel.user
    @media = @reel.media.order("position")
    @featured_video = @videos.where(featured_medium: true)
    @credits = Credit.by_reel(params[:id]).accepted
  end

  def new
    return redirect_with_error(AUTH_NOTICE) unless user_signed_in?
    @reel = Reel.new
  end

  def create
    if user_signed_in?
      @reel = Reel.new(params[:reel])
      @reel.user = current_user
      if @reel.save
        redirect_to @reel
      else
        render "new"
      end
    else
      flash[:notice] = "You must be signed in to create a reel."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  def edit
    @reel = Reel.find(params[:id])
    @media = @reel.media.order("position")

    unless current_user && current_user == @reel.user
      redirect_to :root
      flash[:notice] = "You do not have permission to view that page."
    end
  end

  def update
    @reel = Reel.find(params[:id])
    if @reel.update_attributes( params[:reel] )
      flash[:notice] = "Your reel's been updated!"
      redirect_to @reel
    else
      flash[:notice] = "Woops! Your changes couldn't be saved."
      render 'edit'
    end
  end

  def destroy
    @reel = Reel.find(params[:id])
    @reel.destroy
    redirect_to current_user
  end

  def sort
    params[:medium].each_with_index do |id, index|
      Medium.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  private

  def set_interests
    @interests = Interest.includes(:tags)
  end
end
