class ImagesController < ApplicationController

  def create
    if user_signed_in?
      @reel = params[:media][:reel_id]
      @image = Image.new(reel_id: params[:media][:reel_id],
                         title: params[:title],
                         description: params[:description],
                         photo: params[:file] )  
      if @image.save
        redirect_to reel_path(@reel)
        flash[:notice] = "Image added!"

      else
        #TODO: check validation errors
        flash[:error] = "Error. Please try again."
        redirect_to new_video_url
      end
    else
      flash[:notice] = "You must be signed in to upload an image."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

end
