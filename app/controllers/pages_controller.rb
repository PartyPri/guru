class PagesController < ApplicationController
  before_filter :authenticate_user!

  def home
    @posts = Post.order("updated_at desc")
  end
end