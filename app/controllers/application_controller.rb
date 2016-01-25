class ApplicationController < ActionController::Base
  AUTH_NOTICE = "You must be signed in to perform this action"
  PERMISSION_NOTICE = "You do not have permission to perform this action"
  GENERAL_ERROR = "Oops! Something went wrong."

  protect_from_forgery
end
