class UsersController < ApplicationController
  def show
    @user = User.where(id: params[:id]).first
    if @user.blank?
      redirect_to :root#, error: "User could not be found"
    else
      @interests = @user.interests
    end
  end
end