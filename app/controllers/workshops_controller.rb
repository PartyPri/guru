class WorkshopsController < ApplicationController
  def show
  	@workshop = Workshop.find(params[:id])
    #@interests = @workshop.interests
  end
end