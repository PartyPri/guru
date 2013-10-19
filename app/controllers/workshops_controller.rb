class WorkshopsController < ApplicationController
  def show
    @workshop = Workshop.where(id: params[:id]).first
    if @workshop.blank?
      redirect_to :root#, error: "User could not be found"
    else
      @interests = @workshop.interests
    end
  end
end