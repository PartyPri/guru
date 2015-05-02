class ClaimUsersController < ApplicationController
  def new
  end

  def create
    @claim_users = params[:claim_users]
    @email = params[:claim_users][:email]
    @user = User.find_by_email(@email)
    @token = @user.claim_token
    ClaimUserMailer.claim_user(@email, @token).deliver
    redirect_to '/'
    flash[:success] = "Email sent!"
  end
end
