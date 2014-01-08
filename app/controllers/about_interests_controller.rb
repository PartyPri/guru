class AboutInterestsController < ApplicationController
  def show
    @interest = Interest.find(params[:id])
    @followers = @interest.users
  end
end
