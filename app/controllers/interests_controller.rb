class InterestsController < ApplicationController
  def show
    @interest = Interest.where(id: params[:id]).first
    if @interest.blank?
      redirect_to :root#, error: "Post could not be found"
    else
      @interest = Interest.find(params[:id])
      @followers = @interest.users
      @reels = @interest.reels.order("updated_at desc")
    end
  end
end