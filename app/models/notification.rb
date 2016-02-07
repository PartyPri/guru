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
  end
end
