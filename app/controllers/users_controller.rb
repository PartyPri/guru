class UsersController < ApplicationController
  def show
    @user = User.where(id: params[:id]).first
    redirect_to :root, error: "User could not be found" unless @user
    @interests = @user.interests
  end
end