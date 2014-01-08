class UsersController < ApplicationController
  def show
    @user = User.where( id: params[:id] ).first
    if @user.blank?
      redirect_to :root#, error: "User could not be found"
    else
      @interests      = @user.interests
      @posts          = @user.posts
      @workshops      = @user.workshops
      @followers      = @user.followers
      @followed_users = @user.followed_users
    end
  end

  def update
    @user = User.update( params[:user] )
    @user.update_attribute(:avatar, params[:user][:avatar])
  end
end