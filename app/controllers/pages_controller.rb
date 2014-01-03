class PagesController < ApplicationController
  before_filter :authenticate_user!

  def home
    @posts = Post.all
  end
end