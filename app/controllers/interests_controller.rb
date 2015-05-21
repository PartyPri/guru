class InterestsController < ApplicationController
  def show
    @interest = Interest.where(id: params[:id]).first
    @tags = @interest.reels.tag_counts

    if @interest.blank?
      redirect_to :root
    else
      @interest = Interest.find(params[:id])
      @followers = @interest.users
      @reels = @interest.reels.order("updated_at desc")
    end
  end
end
