class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?

      @claim_token = request.env['omniauth.params']['claim_token']
      @create_reel = request.env['omniauth.params']['create_reel']

      if @claim_token
        @claim_user = User.find_by_claim_token(@claim_token)
        if @claim_user
          @user.update_claim_attributes(@claim_token, @claim_user)
        end
      end

      unless @create_reel.nil?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in @user, :event => :authentication
        redirect_to "/reels/new"
      else
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in @user, :event => :authentication
        redirect_to user_path(@user)
      end

    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
