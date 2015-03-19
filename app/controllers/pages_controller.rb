class PagesController < ApplicationController

  #before_filter :authenticate_user!, :only => [ :home ]

  def home
  end

  def landing
    @email_contact = EmailContact.new
  end

  def about
  end

end