class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?

      @claim_token = request.env['omniauth.params']['claim_token']

      if @claim_token
        @claim_user = User.find_by_claim_token(@claim_token)
        if @claim_user
          @user.update_claim_attributes(@claim_token, @claim_user.first_name, @claim_user.last_name)
        end
      end

      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
