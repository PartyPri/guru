class ProfilesController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	if @user
  		render action: :show
  	else
  	render file: 'public/404', status: 404, formats: [:html]
  	end
  	@interests = @user.interests
  end
end
