class PagesController < ApplicationController

  def home
  end

  def landing
    @email_contact = EmailContact.new
  end

  def about
  end

  def select_media
    @reels = current_user.reels.all
  end

end
