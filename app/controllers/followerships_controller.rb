class FollowershipsController < ApplicationController
  def create
    if user_signed_in? && current_user.id != params[:id]
      followership = Followership.new(follower_id: current_user.id, user_id: params[:id])
      if !followership.save
        flash[:error] = "You are already following this person!"
      end
      redirect_to user_path(params[:id])
    else
      redirect_to :root
    end
  end

  def show
    @user = User.find(params[:id])
    @followers      = @user.followers
    @followed_users = @user.followed_users    
  end

  def show_following
    @user = User.find(params[:id])
    @followers      = @user.followers
    @followed_users = @user.followed_users    
  end

  def destroy
    @followership = Followership.find(params[:id])
    @followership.destroy
    redirect_to user_path(@followership.user)
  end
end
