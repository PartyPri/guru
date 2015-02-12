class ReelsController < ApplicationController

  def show
    @user = User.where( id: params[:id] ).first
    @reel = Reel.includes(:images, :videos).find(params[:id])
    @images = @reel.images
    @videos = @reel.videos
  end

  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    @reel = Reel.new
  end

  def create
    if user_signed_in?
      @reel = Reel.new(params[:reel])  
      @reel.user = current_user
      if @reel.save
        redirect_to @reel.user
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

  private
    def reel_params
      params.require(:reel).permit(:image_id, :video_id)
    end
end
