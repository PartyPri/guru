class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  def show
    @user = User.where( id: params[:id] ).first
    if @user.blank?
      redirect_to :root#, error: "User could not be found"
    else
      @interests      = @user.interests
      @reels          = @user.reels.order("updated_at desc")
      @followers      = @user.followers
      @followed_users = @user.followed_users

    
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])  
    if @user.update_attributes( params[:user] )
      flash[:notice] = "Profile Updated."
      redirect_to @user
    else
      flash[:notice] = "Saving failed. Please try again"
      render 'edit'
    end
  end
end