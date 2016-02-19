class NotificationMailer < ActionMailer::Base
  default from: "Evrystep@evrystep.com"

  class Error < StandardError
    def initialize(message)
      super(message)
    end
  end

  def send_notification(notification_id:)
    notification(notification_id)
    validate!
    mail(to: to, subject: subject)
  end

  private

  def to
    receiver.try(:email)
  end

  def subject
    notification.message
  end

  def validate!
    raise Error.new("Notification not found") unless notification
    raise Error.new("Receiver email cannot be blank") unless to
    raise Error.new("Action Taker cannot be blank") unless action_taker
    raise Error.new("Action Taken On cannot be blank") unless action_taken_on
  end

  def notification(id = nil)
    @notification ||= Notification.includes(:action_taker, :receiver, :action_taken_on).find_by_id(id)
  end

  def action_taker
    @action_taker ||= @notification.action_taker
  end

  def receiver
    @receiver ||= @notification.receiver
  end

  def action_taken_on
    @action_taken_on ||= @notification.action_taken_on
  end
end
