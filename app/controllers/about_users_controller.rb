class AboutUsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followers = @user.followers
  end 
end
