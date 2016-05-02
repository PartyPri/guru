class ImagesController < ApplicationController
  def new
    unless user_signed_in? && !current_user.reels.empty?
      flash[:notice] = "You must be signed in and have at least 1 reel"
      redirect_to :root
    end
    @image = Image.new
    @milestone_options = [[' Eureka', 'eureka', 'fa-lightbulb-o'], [' Mission Accomplished', 'mission_accomplished', 'fa-flag-checkered'], [' Challenge', 'challenge', 'fa-exclamation-triangle'], [' Victory', 'victory', 'fa-trophy'], [' Done', 'done', 'fa-check-square'], [' Experiment', 'experiment', 'fa-flask'], [' Lesson Learned', 'lesson_learned', 'fa-bookmark'] ]
  end

  def create
    if user_signed_in?
      @reel = params[:video][:reel_id]
      @image = Image.new(reel_id: params[:video][:reel_id],
                         title: params[:video][:reel_id],
                         description: params[:video][:description],
                         photo: params[:video][:file],
                         milestone: params[:video][:milestone] )
      if @image.save
        # send success header
        render json: { message: "success", fileID: @image.id }, :status => 200
      else
        #  you need to send an error header, otherwise Dropzone
        #  will not interpret the response as an error:
        render json: { error: @image.errors.full_messages.join(',')}, :status => 400
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

  def destroy
    @image = Image.find(params[:id])
    if @image.destroy
      render json: { message: "File deleted from server" }
    else
      render json: { message: @image.errors.full_messages.join(',') }
    end
  end

end
