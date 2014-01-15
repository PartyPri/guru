class ActivitiesController < ApplicationController
  def show
    @activity = Activity.where(id: params[:id]).first
    if @activity.blank?
      redirect_to :root#, error: "Post could not be found"
    else
      @activity = Activity.find(params[:id])
      @posts = @activity.posts.order("updated_at desc")
    end
  end
end