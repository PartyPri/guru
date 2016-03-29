class ImagesController < ApplicationController

  def create
    if user_signed_in?
      @reel = params[:video][:reel_id]
      @image = Image.new(reel_id: params[:video][:reel_id],
                         title: params[:video][:reel_id],
                         description: params[:video][:description],
                         photo: params[:video][:file],
                         milestone: params[:video][:milestone] )
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

  def upvote
    @image = Image.find(params[:id])
    @image.upvote_by current_user
    
    if request.xhr?
      render json: { count: @image.score, id: params[:id] }
    else
      redirect_to current_user
    end
  end

end
