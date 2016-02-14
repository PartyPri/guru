class Notification < ActiveRecord::Base
  include EnumHelper
  include ActionView::Helpers::DateHelper

  PATH_HELPER = Rails.application.routes.url_helpers

  attr_accessible :action_taker_id, :action, :read, :receiver_id, :action_taken_on_id, :action_taken_on_type,
    :action_taker, :action_taken_on, :receiver

  belongs_to :action_taker, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :action_taken_on, polymorphic: true

  enum(:action, :gave_props, :sent_credit, :accepted_credit_invite, :commented_on)

  scope :by_receiver, -> (receiver_id) { where(receiver_id: receiver_id) }
  scope :unread, -> { where(read: false) }
  scope :newest, -> { order("created_at desc") }

  after_create :send_notification


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
        ""
      when :accepted_credit_invite
        "#{action_taker_name(n)} accepted your credit on the #{obj_class(n)}" \
        " \"#{obj_name(n)}\""
      when :commented_on
        "#{action_taker_name(n)} commented on your #{obj_class(n)} \"#{obj_name(n)}\""
      end
    end

    def action_taker_name(n)
      n.action_taker.try(:first_name)
    end

    def obj_class(n)
      n.action_taken_on.class.name.downcase
    end

    def obj_name(n)
      return unless n.action_taken_on
      return n.action_taken_on.name if n.action_taken_on.respond_to?(:name)
      return n.action_taken_on.description if n.action_taken_on.respond_to?(:description)
    end
  end

  def action
    self.class.action_states[self[:action]]
  end

  def message
    self.class.message(self)
  end

  def action_taker_avatar_url
    action_taker.try(:avatar).try(:url)
  end

  def action_happened_at
    "#{time_ago_in_words(created_at)} ago"
  end

  def path_to_reel(reel = nil)
    reel = action_taken_on_id if action_taken_on_reel?
    reel = action_taken_on.reel_id if action_taken_on_medium?
    return unless reel
    PATH_HELPER.reel_path(reel)
  end

  def action_taken_on_reel?
    action_taken_on_type == "Reel"
  end

  def action_taken_on_medium?
    action_taken_on_type == "Medium"
  end

  private

  def send_notification
    NotificationMailer.delay.send_notification(notification_id: id)
  end
end
