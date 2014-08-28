class ImagesController < ApplicationController
  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    @image = Image.new
    @user = current_user
  end

  def create
    if user_signed_in?
      @image = Image.new(params[:image])  
      @user = current_user
      if @image.save
        redirect_to @user
        flash[:notice] = "Image added!"

      else
        render "new"
      end
    else
      flash[:notice] = "You must be signed in to upload an image."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  private
    def reel_params
      params.require(:image).permit(:reels)
    end
end
