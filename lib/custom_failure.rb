class CustomFailure < Devise::FailureApp

  # Redirect to alternate url
  # Reference http://stackoverflow.com/questions/4180386/redirecting-issues-when-user-cannot-sign-in-using-devise
  def redirect_url
    if warden_options[:scope] == :user 
      landing_path 
    else 
      new_admin_user_session_path 
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end