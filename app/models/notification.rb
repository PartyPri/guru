class Notification < ActiveRecord::Base
  include EnumHelper

  attr_accessible :action_taker_id, :action, :read, :receiver_id, :action_taken_on_id, :action_taken_on_type

  belongs_to :action_taker, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :action_taken_on, polymorphic: true

  enum(:action, :gave_props, :sent_credit, :accepted_credit_invite, :commented_on)

  module Helper
    module InstanceMethods
      def notify
        Notification.create(
          action_taker:
        )
      end
    end

    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end
