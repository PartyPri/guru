class CustomFailure < Devise::FailureApp

  # Redirect to alternate url
  # Reference http://stackoverflow.com/questions/4180386/redirecting-issues-when-user-cannot-sign-in-using-devise
  def respond
    if http_auth?
      http_auth
    else
      redirect_to landing_url
    end
  end
end