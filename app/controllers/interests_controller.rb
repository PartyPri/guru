class InterestsController < ApplicationController
  def show
    @interest = Interest.find(params[:id])
    @users = @interest.users
  end
end