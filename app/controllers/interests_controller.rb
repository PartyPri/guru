class InterestsController < ApplicationController
  def show
    @interest = Interest.where(id: params[:id]).first

    if @interest.blank?
      redirect_to :root
    else
      @interest = Interest.find(params[:id])
      @tags = @interest.reels.tag_counts
      @followers = @interest.users
      @reels = @interest.reels.order("updated_at desc")
    end
  end
end
