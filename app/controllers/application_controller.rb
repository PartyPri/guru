class ApplicationController < ActionController::Base
  AUTH_NOTICE = "You must be signed in to perform this action"
  PERMISSION_NOTICE = "You do not have permission to perform this action"
  GENERAL_ERROR = "Oops! Something went wrong."

  protect_from_forgery
  helper_method :owned_by_current_user?

  def redirect_with_notice(message, path = :root)
    flash[:notice] = message
    redirect_to(path)
  end

  def owned_by_current_user?
    return false unless user_signed_in?
    @user == current_user
  end
end
