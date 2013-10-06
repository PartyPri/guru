class UserInterestsController < ApplicationController
  def create
    if user_signed_in?
      UserInterest.create(user_id: current_user.id, interest_id: params[:id])
      redirect_to :root
    end
  end
end