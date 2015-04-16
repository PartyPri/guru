class ClaimUsersController < ApplicationController
  def new
    ClaimUserMailer.claim_user.deliver
  end

  def create
    
  end
end
