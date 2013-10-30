class PagesController < ApplicationController
  before_filter :authenticate_user!

  def home
    @workshops = Workshop.all
  end
end