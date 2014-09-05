class VideosController < ApplicationController
  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    @video = Video.new
    @user = current_user
  end

  def create
    if user_signed_in?
      @video = Video.new(params[:video])
      @user = current_user
      if @video.save
        redirect_to @user
        flash[:notice] = "Video added!"

      else
        render "new"
      end
    else
      flash[:notice] = "You must be signed in to upload an video."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  private
    def reel_params
      params.require(:video).permit(:reel_id)
    end
end
