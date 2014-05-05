class UserInterestsController < ApplicationController
  def create
    if user_signed_in?
      user_interest = UserInterest.new(user_id: current_user.id, interest_id: params[:id])
      if user_interest.save
        #flash[:notice] = "Added"
      else
        flash[:error] = "You're already following this!"
      end
      redirect_to interest_path(params[:id])
    end
  end

  def show
    @interest = Interest.find(params[:id])
    @followers = @interest.users    
  end

  def destroy
    @user_interest = UserInterest.find(params[:id])
    @user_interest.destroy
    redirect_to interest_path(@user_interest.interest)
  end
end