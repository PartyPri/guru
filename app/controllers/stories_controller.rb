class StoriesController < ApplicationController

  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    @story = Story.new
    @milestone_options = [[' Eureka', 'eureka', 'fa-lightbulb-o'], [' Mission Accomplished', 'mission_accomplished', 'fa-flag-checkered'], [' Challenge', 'challenge', 'fa-exclamation-triangle'], [' Victory', 'victory', 'fa-trophy'], [' Done', 'done', 'fa-check-square'], [' Experiment', 'experiment', 'fa-flask'], [' Lesson Learned', 'lesson_learned', 'fa-bookmark'] ]
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

  def upvote
    @story = Story.find(params[:id])
    @story.upvote_by current_user

    if request.xhr?
      render json: { count: @story.score, id: params[:id] }
    else
      redirect_to current_user
    end
  end
end
