class CustomFailure < Devise::FailureApp
  def redirect_url
    new_user_session_url(:subdomain => 'secure')
  end

  # Redirect to alternate url
  def respond
    if http_auth?
      http_auth
    else
      redirect_to new_user_registration_url
    end
  end
end