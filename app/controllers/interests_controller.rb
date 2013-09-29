class InterestsController < ApplicationController
  def show
    @interest = Interest.find(params[:id])
  end
end