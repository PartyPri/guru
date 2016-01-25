class CreditsController < ApplicationController
  before_filter :validate_user, except: [:index]

  ADDED_NOTICE = "Credit added! Waiting for the credit receiver to accept"
  DELETED_NOTICE = "Credit deleted"
  NOT_FOUND_NOTICE = "Credit not found"

  helper_method :user_validation_notice

  # TODO: remove when implemented fully
  def index
    @reel = Reel.includes(:credits).find_by_id(params[:reel_id])
    @credits = reel.credits
  end

  # TODO: remove when implemented fully
  def new
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

    flash[:notice] = ADDED_NOTICE
    redirect_to reel_path(reel.id)
  end

  def destroy
    credit = reel.credits.where(id: params[:id]).first
    flash[:notice] = destroy_credit(credit)
    redirect_to reel_path(reel.id)
  end

  def destroy_credit(credit)
    return NOT_FOUND_NOTICE if credit.nil?
    return DELETED_NOTICE if credit.destroy
    GENERAL_ERROR
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
    return unless user_validation_notice
    flash[:notice] = user_validation_notice
    redirect_to :root
  end


  def user_validation_notice
    @user_validation_notice ||= begin
      return AUTH_NOTICE unless user_signed_in?
      PERMISSION_NOTICE unless reel
    end
  end

  def reel
    @reel ||= Reel.where(id: params[:reel_id], user_id: current_user.id).first
  end
end
