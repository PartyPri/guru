class ReelsController < ApplicationController

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

    render json: tagged_reels, include: { images: {methods: :photo}, videos: {}, articles: {} }
  end

  def show
    # TODO this should probably removed
    @reel = Reel.includes(:images, :videos).find(params[:id])
    @images = @reel.images
    @videos = @reel.videos
    @user = @reel.user
  end

  def new
    unless user_signed_in?
      redirect_to :root
      flash[:notice] = "You must be signed in to create a reel."
    end
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
end
