class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  def show
    @user = User.where( id: params[:id] ).first
    return redirect_to :root if @user.blank?

    @interests      = @user.interests
    @reels          = Reel.includes(:user).where(user_id: @user.id).recently_added_media
    @entourage      = Credit.includes(:receiver, :reel).accepted.by_reel_owner(@user.id)
    @credited_reels = Credit.includes(:reel).accepted.by_receiver(@user.id).map(&:reel)
#     @all_user       = User.all
#     @credited_in    = Credit.find(:all, :conditions => { :credit_receiver_id => @user.id, :invitation_status => 1})
#     @credited_reels = Reel.find(:all, :conditions => {:id => @credited_in.map(&:reel_id)})
  end

  def edit
  end

  def edit_profile
    @user = User.find(params[:id])

    if current_user && current_user == @user
      render 'edit_profile.haml'
    else
      redirect_to :root
      flash[:notice] = "You do not have permission to view that page."
    end
  end

  def update
    if params[:user][:cropped_image]
      params[:user][:avatar] = params[:user].delete(:cropped_image)
    end

    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile Updated."
      redirect_to @user
    else
      flash[:notice] = "Oops, your info wasn't saved! Please try again."
      render 'edit'
    end
  end
end
