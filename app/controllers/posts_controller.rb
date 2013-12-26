class PostsController < ApplicationController
  def new
  end

  def create
    if user_signed_in?
      @post = Post.new(params[:post])
      @post.user = current_user
      @post.save
      redirect_to @post
    else
      flash[:notice] = "You must be signed in to post!"
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  def show
    @post = Post.where(id: params[:id]).first
    if @post.blank?
      redirect_to :root#, error: "Post could not be found"
    else
      @user       = @post.user
      @interests  = @post.interests
      @activities = @post.activities
    end
  end

  def update
    params[:post][:interests] ||= []
    params[:post][:activities] ||= []
  end

  private
  def post_params
    params.require(:post).permit(:caption)
  end
end
