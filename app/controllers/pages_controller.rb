class PagesController < ApplicationController
  #before_filter :authenticate_user!

  def home
    @email_contact = EmailContact.new
  end
end