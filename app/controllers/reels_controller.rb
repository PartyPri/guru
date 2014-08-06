class ReelsController < ApplicationController
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
end
