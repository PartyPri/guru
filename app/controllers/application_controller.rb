class ApplicationController < ActionController::Base
  AUTH_NOTICE = "You must be signed in to perform this action"
  PERMISSION_NOTICE = "You do not have permission to perform this action"
  GENERAL_ERROR = "Oops! Something went wrong."

  protect_from_forgery
  helper_method :owned_by_current_user?
  before_filter :notifications

  def redirect_with_notice(message, path = :root)
    flash[:notice] = message
    redirect_to(path)
  end

  def owned_by_current_user?
    return false unless user_signed_in?
    @user == current_user
  end

  def notifications
    return unless user_signed_in?
    @notifications = Notification.by_receiver(current_user.id).unread.newest
  end

  def authenticate_user!
    return if user_signed_in?
    redirect_with_notice(AUTH_NOTICE)
  end
end
