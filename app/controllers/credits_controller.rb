class CreditsController < ApplicationController
  before_filter :validate_user, except: [:index]

  def index
    @reel = Reel.includes(:credits).find_by_id(params[:reel_id])
    @credits = reel.credits
  end

  def new
    @credit = Credit.new
  end

  def create
    @credit = Credit.new(
      reel_id: reel.id,
      credit_receiver_id: credit_receiver.try(:id),
      reel_owner_id: reel.user_id,
      role: params[:credit][:role],
      credit_receiver_email: credit_receiver_email
    )

    # TODO: send email to credit_receiver
    return render :new unless @credit.save

    flash[:notice] = "Credit added! Waiting for the credit receiver to accept"
    redirect_to reel_path(reel) #reel_credits_path(reel.id)
  end

  def destroy
  end

  def credit_receiver_email
    params[:credit][:credit_receiver_email]
  end

  def credit_receiver
    @credit_receiver = User.find_by_email(credit_receiver_email)
  end

  def correct_user?
    reel.present?
  end

  def validate_user
    return unless notice = user_validation_notice
    flash[:notice] = notice
    redirect_to :root
  end

  def user_validation_notice
    notice = "You must be signed in to perform this action" unless user_signed_in?
    return notice if notice
    "You do not have permission to perform this action" unless reel
  end

  def reel
    @reel ||= Reel.where(id: params[:reel_id], user_id: current_user.id).limit(1).first
  end
end
