class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def update
    @notification = Notification.find_by_id(params[:id])
    @notification.read = params[:read]
    return head(:ok) if @notification.save
    render status: 422
  end
end
