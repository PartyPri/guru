class ProjectsController < ApplicationController
  def new
    @project = Project.new
    #@project.user = current_user
    #@project.videos.build
  end

  def create
    if user_signed_in?
      @project = Project.new(params[:project])  
      @project.user = current_user
      @project.save
      redirect_to @project
    else
      flash[:notice] = "You must be signed in to create a project!"
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  # def add_media
  #   @project = Project.find(params[:id])
  #   if @project.update_attributes(params[:project])
  #     #flash[:notice] = "Your media's been added to the project!"
  #   end
  #   #redirect_to add_media_path(@project)
  # end

  def show
    @project = Project.where(id: params[:id]).first
    if @project.blank?
      redirect_to :root#, error: "Project could not be found"
    else
      @user       = @project.user
      @media      = (@project.videos + @project.images).sort_by &:created_at
    end
  end

  def update
    @project = Project.find(params[:id])
    unless current_user.id == @project.user.id
      redirect_to :root#error
    end
    if @project.update_attributes(params[:project])
      #flash[:notice] = "Your media's been added to the project!"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def edit
    @project = Project.find(params[:id])
    unless current_user.id == @project.user.id
      redirect_to :root#error
    end
    @user       = @project.user
    @media      = (@project.videos + @project.images).sort_by &:created_at
  end

  def destroy
    @project = Project.find(params[:id])
    unless current_user.id == @project.user.id
      redirect_to :root#error
    end
    @project.destroy
    flash[:notice] = "Project deleted"
    redirect_to :back
  end

  private
    def project_params
      params.require(:project).permit(:images, :videos, :_destroy, :image_ids, :video_ids, :photo_file_name)
    end
end
