class CreditsController < ApplicationController
  before_filter :sign_in_user, only: [:respond_to_invitation]
  before_filter :validate_user, except: [:index, :respond_to_invitation]

  ADDED_NOTICE = "Credit added! Waiting for the credit receiver to accept."
  DELETED_NOTICE = "Credit deleted."
  NOT_FOUND_NOTICE = "Credit not found."

  def create
    @credit = Credit.new(
      reel_id: reel.id,
      credit_receiver_id: credit_receiver.try(:id),
      reel_owner_id: reel.user_id,
      role: params[:credit][:role],
      credit_receiver_email: credit_receiver_email
    )

    return redirect_with_notice(GENERAL_ERROR) unless @credit.save

    redirect_with_notice(ADDED_NOTICE, reel_path(reel))
  end

  def destroy
    credit = reel.credits.where(id: params[:id]).first
    flash[:notice] = destroy_credit(credit)
    redirect_to reel_path(reel.id)
  end

  def respond_to_invitation
    path = reel_path(params[:reel_id])

    return redirect_with_notice(AUTH_NOTICE, path) unless user_signed_in?

    credit = Credit.where(id: params[:id], reel_id: params[:reel_id]).first
    return redirect_with_notice(NOT_FOUND_NOTICE, path) unless credit

    credit.assign_attributes(
      new_state => true,
      credit_receiver_id: current_user.id,
      credit_receiver_email: current_user.email
    )
    return redirect_with_notice("Credit #{new_state}!", path) if credit.save

    redirect_with_notice(GENERAL_ERROR, path)
  end

  private

  def new_state
    @new_state ||= begin
      new_state = request.fullpath.split("/").last
      "#{new_state}ed".to_sym
    end
  end

  def send_invitation
    CreditInvitationMailer.delay.send_invitation(credit_id: @credit.id)
  rescue => e
    Rails.logger.error(e)
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

  def sign_in_user
    return if user_signed_in?
    redirect_to user_omniauth_authorize_path(:google_oauth2, redirect_path: request.fullpath)
  end
end
