class ActivitiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    followed_ids = current_user.followed_users.pluck("users.id")
    @activities = Activity.where(followed_user_id: followed_ids)
  end
end