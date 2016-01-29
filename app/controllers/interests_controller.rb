class InterestsController < ApplicationController
  def show
    @interest = Interest.find_by_id(params[:id])
    return redirect_to :root unless @interest

    @tags = @interest.reels.tag_counts
    @followers = @interest.users
    @reels = @interest.reels.includes(:media, :user).with_enough_media.recently_added_media
  end
end
