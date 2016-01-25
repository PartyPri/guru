class Credit < ActiveRecord::Base
  include EnumHelper

  DEFAULT_ROLE = "Fan"

  attr_accessible :invitation_status, :credit_receiver_email, :credit_receiver_id, :reel_id, :reel_owner_id, :role, :pending, :accepted, :rejected

  belongs_to :reel

  # The `enum` method here comes from the EnumHelper module. It gives you a few helper methods:
  #
  # Credit.invitation_status_states => the enum value for each state
  # Credit.new.pending? => boolean value of whether that state is the current one selected
  # Credit.new.pending= => sets the value of invitation_status to the state being set
  #
  enum(:invitation_status, :pending, :accepted, :rejected)

  validates_presence_of :credit_receiver_email, :reel_id, :reel_owner_id, :role

  before_validation :add_default_role

  private

  def add_default_role
    return if role
    self.role = DEFAULT_ROLE
  end
end
