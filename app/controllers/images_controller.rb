class ImagesController < ApplicationController

  def create
    if user_signed_in?
      @image = Image.new(reel_id: params[:media][:reel_id],
                         title: params[:title],
                         description: params[:description])  
      if @image.save
        redirect_to current_user
        flash[:notice] = "Image added!"

      else
        #TODO: show validation errors
        flash[:error] = "Error. Please try again."
        redirect_to new_video_url
      end
    else
      flash[:notice] = "You must be signed in to upload an image."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

end
