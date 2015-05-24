class PagesController < ApplicationController

  def home
  end

  def landing
    @email_contact = EmailContact.new
  end

  def about
  end

end
