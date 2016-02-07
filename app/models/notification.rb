class Notification < ActiveRecord::Base
  include EnumHelper

  attr_accessible :action_taker_id, :action, :read, :receiver_id, :action_taken_on_id, :action_taken_on_type,
    :action_taker, :action_taken_on, :receiver

  belongs_to :action_taker, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :action_taken_on, polymorphic: true

  enum(:action, :gave_props, :sent_credit, :accepted_credit_invite, :commented_on)

  scope :by_receiver, -> (receiver_id) { where(receiver_id: receiver_id) }
  scope :unread, -> { where(read: false) }
  scope :newest, -> { order("created_at desc") }


  class << self
    # Overwrite the .create method to work with enum helper (for now)
    def create(opts = {})
      value = opts[:action]
      opts[:action] = action_states.invert[value] if value.is_a?(Symbol)
      super
    end

    def message(notification)
      name = notification.action_taker.first_name
      {
        gave_props: "#{name} gave you props on your #{obj_class(notification.action_taken_on)} '#{obj_name(notification.action_taken_on)}'",
        sent_credit: "",
        accepted_credit_invite: "#{name} accepted your credit on the #{obj_class(notification.action_taken_on)} '#{obj_name(notification.action_taken_on)}'",
        commented_on: "#{name} commented on your #{obj_class(notification.action_taken_on)} '#{obj_name(notification.action_taken_on)}'"
      }[notification.action]
    end

    def obj_class(action_taken_on)
      action_taken_on.class.name.downcase
    end

    def obj_name(action_taken_on)
      return unless action_taken_on
      return action_taken_on.name if action_taken_on.respond_to?(:name)
      return action_taken_on.description if action_taken_on.respond_to?(:description)
    end
  end

  def action
    self.class.action_states[self[:action]]
  end

  def message
    self.class.message(self)
  end
end
