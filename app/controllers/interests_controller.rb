class InterestsController < ApplicationController
  def show
    @interest = Interest.find(params[:id])
    @users = @interest.users
    @workshops = @interest.workshops
  end
end