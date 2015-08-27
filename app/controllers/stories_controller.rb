class StoriesController < ApplicationController

  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    render 'new.haml'
    @story = Story.new
  end

  def create
    if user_signed_in?
      @story = Story.new(params[:story])
      if @story.save
        redirect_to @story.reel
      else
        render "new"
      end
    else
      flash[:notice] = "You must be signed in to write a story."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  def show
    @story = Story.find(params[:id])
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])  
    if @story.update_attributes( params[:story] )
      flash[:notice] = "Your story has been updated!"
      redirect_to @story.reel
    else
      flash[:notice] = "Woops! Your changes couldn't be saved."
      render 'edit'
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to current_user
  end
end
