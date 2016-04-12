class FollowershipsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  FOLLOW_YOURSELF = "Sorry, but you can't follow yourself"
  ALDREADY_FOLLOWING = "You are already following this person!"
  TYPE_MAP = {
    user: User,
    reel: Reel
  }


  def followed_type
    type_key = params[:followed_type].to_sym
    TYPE_MAP[type_key]
  end

  def followed_id
    params[:followed_id].to_i
  end

  def following_user?
    followed_type.is_a?(User)
  end

  def following_self?
    return false unless following_user?
    current_user.id == followed_id
  end

  def create
    return redirect_with_notice(FOLLOW_YOURSELF) if following_self?
    attrs = {follower_id: current_user.id, followed_type: followed_type.name, followed_id: followed_id}
    followership = Followership.new(attrs)
    return redirect_with_notice(ALDREADY_FOLLOWING, redirect_path) unless followership.save
    flash[:notice] = "You are now following #{followership.followed.try(:reference_title)}"
    redirect_to redirect_path
  end

  def index
    @user = User.find(params[:user_id])
    @followers = @user.followers
    @follows = @user.follows
    @interests = Interest.all
  end

  def destroy
    followership = Followership.where(
      followed_id: followed_id,
      followed_type: followed_type.name,
      follower_id: current_user.id
    ).first
    return redirect_with_notice(GENERAL_ERROR, redirect_path) unless followership.destroy
    flash[:notice] = "You are no longer following #{followership.followed.try(:reference_title)}"
    redirect_to redirect_path
  end

  def redirect_path
    polymorphic_path(params[:followed_type], id: params[:followed_id])
  end
end
