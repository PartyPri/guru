class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def update
    notification = Notification.where(id: params[:id], receiver_id: current_user).first
    return head(:not_found) unless notification
    notification.read = params[:read]
    return head(:ok) if notification.save
    head(:unprocessable_entity)
  end
end
