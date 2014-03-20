class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => [ :home ]

  def home
    @posts = Post.order("updated_at desc")
    @projects = Project.order("updated_at desc")
  end

  def landing
    @email_contact = EmailContact.new
  end

end