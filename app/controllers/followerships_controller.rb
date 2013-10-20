class FollowershipsController < ApplicationController
  def create
    if user_signed_in? && current_user.id != params[:id]
      followership = Followership.new(follower_id: current_user.id, user_id: params[:id])
      if followership.save
        flash[:notice] = "You are now following #{User.find(params[:id]).first_name}!"
      else
        flash[:error] = "You are already following this person!"
      end
      redirect_to user_path(params[:id])
    else
      redirect_to :root
    end
  end
end
