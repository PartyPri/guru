class ReelsController < ApplicationController

  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    @reel = Reel.new
  end

  def create
    if user_signed_in?
      @reel = Reel.new(params[:reel])  
      @reel.user = current_user
      if @reel.save
        redirect_to @reel.user
      else
        render "new"
      end
    else
      flash[:notice] = "You must be signed in to create a reel."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  private
    def reel_params
      params.require(:reel).permit(:images)
    end
end
