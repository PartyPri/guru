class AboutInterestsController < ApplicationController
  def show
    @interest = Interest.find(params[:id])
    @followers = @interest.users
    @reels = @interest.reels.order("updated_at desc")
  end
end
