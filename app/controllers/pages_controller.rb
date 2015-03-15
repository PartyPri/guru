class PagesController < ApplicationController
  #before_filter :authenticate_user!

  def home
    render "home.haml"
    @email_contact = EmailContact.new
  end
end