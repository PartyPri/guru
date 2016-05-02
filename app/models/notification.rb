class Notification < ActiveRecord::Base
  include EnumHelper
  include ActionView::Helpers::DateHelper

  PATH_HELPER = Rails.application.routes.url_helpers

  attr_accessible :action_taker_id, :action, :read, :receiver_id, :action_taken_on_id, :action_taken_on_type,
    :action_taker, :action_taken_on, :receiver, :credit_id

  belongs_to :action_taker, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :action_taken_on, polymorphic: true
  belongs_to :credit

  enum(:action, :gave_props, :sent_credit, :accepted_credit_invite, :commented_on, :added_comment_to_thread)

  scope :by_receiver, -> (receiver_id) { where(receiver_id: receiver_id) }
  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true).limit(10) }
  scope :newest, -> { order("created_at desc") }
  scope :gave_props, -> { where(action: 0) }
  scope :sent_credit, -> { where(action: 1) }
  scope :accepted_credit_invite, -> { where(action: 2) }
  scope :commented_on, -> { where(action: 3) }

  after_create :send_notification

  module ActionTakenOnHelper
    module InstanceMethods
      def destroy_notifications
        Notification.destroy_all(action_taken_on_id: id, action_taken_on_type: self.class.base_class.name)
      end
    end

    def self.included(receiver)
      receiver.send :include, InstanceMethods
      receiver.send(:before_destroy, :destroy_notifications)
    end
  end

  class << self
    # Overwrite the .create method to work with enum helper (for now)
    def create(opts = {})
      value = opts[:action]
      opts[:action] = action_states.invert[value] if value.is_a?(Symbol)
      super
    end

    def message(n)
      case n.action
      when :gave_props
        "#{action_taker_name(n)} gave you props on your #{obj_class(n)}" \
        " \"#{obj_name(n)}\""
      when :sent_credit
        "#{action_taker_name(n)} wants to credit you on the #{obj_class(n)}" \
        " \"#{obj_name(n)}\""
      when :accepted_credit_invite
        "#{action_taker_name(n)} accepted your credit on the #{obj_class(n)}" \
        " \"#{obj_name(n)}\""
      when :commented_on
        "#{action_taker_name(n)} commented on your #{obj_class(n)} \"#{obj_name(n)}\""
      when :added_comment_to_thread
        "#{action_taker_name(n)} added a new comment to #{obj_class(n)} \"#{obj_name(n)}\""
      end
    end

    def action_taker_name(n)
      n.action_taker.try(:first_name)
    end

    def obj_class(n)
      klass = n.action_taken_on.class
      klass.name.downcase
    end

    def obj_name(n)
      return unless n.action_taken_on
      return unless n.action_taken_on.respond_to?(:reference_title)
      n.action_taken_on.reference_title
    end
  end

  def action
    self.class.action_states[self[:action]]
  end

  def message
    self.class.message(self)
  end

  def message_with_link
    link = "<a href='#{path_to_action_taken_on}'>#{self.class.obj_class(self)}</a>"
    m = message.gsub(self.class.obj_class(self), link)
    m || message
  end

  def action_taker_avatar_url
    action_taker.try(:avatar).try(:url)
  end

  def action_happened_at
    "#{time_ago_in_words(created_at)} ago"
  end

  def path_to_action_taken_on
    return action_taken_on_reel_url if action_taken_on_reel?
    return action_taken_on_medium_url if action_taken_on_medium?
  end

  def action_taken_on_reel_url
    url = PATH_HELPER.reel_url(action_taken_on_id)
    return url unless credit_id
    return unless credit
    "#{url}?#{credit.invitation_opts.to_query}"
  end

  def action_taken_on_medium_url
    PATH_HELPER.reel_url(action_taken_on.reel_id, anchor: "media-#{action_taken_on_id}")
  end

  def action_taken_on_reel?
    action_taken_on_type == "Reel"
  end

  def action_taken_on_medium?
    action_taken_on_type == "Medium"
  end

  private

  def sent_credit?
    action == :sent_credit
  end

  def send_notification
    if sent_credit?
      CreditInvitationMailer.delay.send_invitation(credit_id: credit_id)
    else
      NotificationMailer.delay.send_notification(notification_id: id)
    end
  end
end

# == Schema Information
#
# Table name: notifications
#
#  id                   :integer          not null, primary key
#  read                 :boolean          default(FALSE)
#  action               :integer          default(0)
#  receiver_id          :integer
#  action_taker_id      :integer
#  action_taken_on_id   :integer
#  action_taken_on_type :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  credit_id            :integer
#
