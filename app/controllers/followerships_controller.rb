class FollowershipsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  FOLLOW_YOURSELF = "Sorry, but you can't follow yourself"
  ALDREADY_FOLLOWING = "You are already following this person!"

  def create
    return redirect_with_notice(FOLLOW_YOURSELF) if current_user.id == params[:user_id].to_i

    followership = Followership.new(follower_id: current_user.id, user_id: params[:user_id])
    return redirect_with_notice(ALDREADY_FOLLOWING, redirect_path) unless followership.save
    flash[:notice] = "You are now following #{followership.user.try(:first_name)}"
    redirect_to redirect_path
  end

  def index
    @user = User.find(params[:user_id])
    @followers = @user.followers
    @follows = @user.follows
    @interests = Interest.all
  end

  def destroy
    followership = Followership.where(user_id: params[:user_id], follower_id: current_user.id).first
    return redirect_with_notice(GENERAL_ERROR, redirect_path) unless followership.destroy
    flash[:notice] = "You are no longer following #{followership.user.try(:first_name)}"
    redirect_to redirect_path
  end

  def redirect_path
    user_path(params[:user_id])
  end
end
