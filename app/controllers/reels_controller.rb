class ReelsController < ApplicationController
<<<<<<< HEAD
  # def new
  #   unless user_signed_in?
  #     redirect_to :root#error
  #   end
  #   @reel = Reel.new
  # end

  # def create
  #   if user_signed_in?
  #     @reel = Reel.new(params[:reel)  
  #     @reel.user = current_user
  #     if @reel.save
  #       redirect_to @reel
  #     else
  #       render "new"
  #     end
  #   else
  #     flash[:notice] = "You must be signed in to create a reel!"
  #     redirect_to :root #TODO Redirect to sign up page
  #   end
  # end

  # def show
  #   @reel = Reel.where(id: params[:id]).first
  #   if @reel.blank?
  #     redirect_to :root#, error: "Project could not be found"
  #   else
  #     @user       = @reel.user
  #     @media      = (@reel.videos + @reel.images).sort_by &:created_at
  #   end
  # end

  # def update
  #   @project = Project.find(params[:id])
  #   unless current_user.id == @project.user.id
  #     redirect_to :root#error
  #   end
  #   if @project.update_attributes(params[:project])
  #     #flash[:notice] = "Your media's been added to the project!"
  #     redirect_to @project
  #   else
  #     render 'edit'
  #   end
  # end

  # def edit
  #   @project = Project.find(params[:id])
  #   unless current_user.id == @project.user.id
  #     redirect_to :root#error
  #   end
  #   @user       = @project.user
  #   @media      = (@project.videos + @project.images).sort_by &:created_at
  # end

  # def destroy
  #   @project = Project.find(params[:id])
  #   unless current_user.id == @project.user.id
  #     redirect_to :root#error
  #   end
  #   @project.destroy
  #   flash[:notice] = "Project deleted"
  #   redirect_to :back
  # end

  # private
  #   def project_params
  #     params.require(:project).permit(:images, :videos, :image_ids, :video_ids)
  #   end 

  # private
  #   def project_params
  #     params.require(:project).permit(:images, :videos, :_destroy, :image_ids, :video_ids, :photo_file_name)
  #   end  
=======

  def show
    # TODO this should probably removed
    @reel = Reel.includes(:images, :videos).find(params[:id])
    @images = @reel.images
    @videos = @reel.videos
    @user = @reel.user#User.where( id: params[:id] ).first
  end

  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    render 'new.haml'
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
>>>>>>> develop
end
