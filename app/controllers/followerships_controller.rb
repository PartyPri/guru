class FollowershipsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  FOLLOW_YOURSELF = "Sorry, but you can't follow yourself"
  ALDREADY_FOLLOWING = "You are already following this person!"

  def create
    return redirect_with_notice(FOLLOW_YOURSELF) if current_user.id == params[:id].to_i

    followership = Followership.new(follower_id: current_user.id, user_id: params[:id])
    path = user_path(params[:id])
    return redirect_with_notice(ALDREADY_FOLLOWING, path) unless followership.save
    flash[:notice] = "You are now following #{followership.user.try(:first_name)}"
    redirect_to path
  end

  def index
    @user = User.find(params[:id])
    @followers = @user.followers
    @follows = @user.follows
    @interests = Interest.all
  end

  def destroy
    @followership = Followership.find(params[:id])
    @followership.destroy
    redirect_to user_path(@followership.user)
  end
end
