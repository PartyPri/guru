class UserInterestsController < ApplicationController
  def create
    if user_signed_in?
      user_interest = UserInterest.new(user_id: current_user.id, interest_id: params[:id])
      if user_interest.save
        flash[:notice] = "Added"
      else
        flash[:error] = "You are already signed up!"
      end
      redirect_to interest_path(params[:id])
    end
  end
end