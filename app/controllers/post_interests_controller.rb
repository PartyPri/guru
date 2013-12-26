class PostInterestsController < ApplicationController
  def create
    if user_signed_in?
      post_interest = Post_interest.new(post_id: @post.id, user_id: params[:id])
      post_interest.save
    else
      flash[:notice] = "You must be signed in to post!"
      redirect_to :root #TODO Redirect to sign up page
    end
  end
end
