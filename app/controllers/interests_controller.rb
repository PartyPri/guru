class InterestsController < ApplicationController
  def show
    @interest = Interest.find_by_id(params[:id])
    return redirect_to :root unless @interest

    @tags = @interest.reels.tag_counts
    @followers = @interest.users
    @reels = @interest.reels.where("media_count > 2").order("media_last_added_at desc")
  end
end
