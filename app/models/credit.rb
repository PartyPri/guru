class Credit < ActiveRecord::Base
  include EnumHelper

  DEFAULT_ROLE = "Fan"

  attr_accessible :invitation_status, :credit_receiver_email, :credit_receiver_id, :reel_id, :reel_owner_id, :role, :pending, :accepted, :rejected

  belongs_to :reel
  belongs_to :owner, class_name: "User", foreign_key: :reel_owner_id
  belongs_to :receiver, class_name: "User", foreign_key: :credit_receiver_id

  # The `enum` method here comes from the EnumHelper module. It gives you a few helper methods:
  #
  # Credit.invitation_status_states => the enum value for each state
  # Credit.new.pending? => boolean value of whether that state is the current one selected
  # Credit.new.pending= => sets the value of invitation_status to the state being set
  #
  enum(:invitation_status, :pending, :accepted, :rejected)

  validates_presence_of :reel_id, :reel_owner_id, :role
  validates_presence_of :credit_receiver_email, :credit_receiver_id, unless: :pending?

  before_validation :set_default_role
  before_validation :set_reel_owner
  before_validation :set_credit_receiver_email
  before_validation :set_credit_receiver_id

  after_save :notify_acceptance
  after_save :notify_creation
  before_destroy :destroy_notifications

  scope :by_reel, -> (reel_id) { where(reel_id: reel_id) }
  scope :by_reel_owner, -> (reel_owner_id) { where(reel_owner_id: reel_owner_id) }
  scope :accepted, -> { where(invitation_status: 1) }
  scope :pending, -> { where(invitation_status: 0) }
  scope :by_receiver, ->(credit_receiver_id) { where(credit_receiver_id: credit_receiver_id) }

  def invitation_opts
    {credit_invitation: id}
  end

  private

  def notify_acceptance
    return unless invitation_status_changed?
    return unless accepted?
    Notification.create(
      action_taker_id: credit_receiver_id,
      action_taken_on_id: reel_id,
      action_taken_on_type: "Reel",
      receiver_id: reel_owner_id,
      action: :accepted_credit_invite,
    )
  end

  def notify_creation
    return unless id_changed?
    return unless pending?
    Notification.create(
      action_taker_id: reel_owner_id,
      action_taken_on_id: reel_id,
      action_taken_on_type: "Reel",
      receiver_id: credit_receiver_id,
      action: :sent_credit,
      credit_id: id
    )
  end

  def set_reel_owner
    return if reel_owner_id
    self.reel_owner_id = reel.try(:user_id)
  end

  def set_credit_receiver_email
    return if credit_receiver_email
    self.credit_receiver_email = receiver.try(:email)
  end

  def set_credit_receiver_id
    return if credit_receiver_id
    self.credit_receiver_id = User.find_by_email(credit_receiver_email).try(:id)
  end

  def set_default_role
    return if role
    self.role = DEFAULT_ROLE
  end

  def destroy_notifications
    Notification.destroy_all(credit_id: id)
  end
end

# == Schema Information
#
# Table name: credits
#
#  id                    :integer          not null, primary key
#  reel_id               :integer
#  reel_owner_id         :integer
#  credit_receiver_id    :integer
#  role                  :string(255)
#  credit_receiver_email :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  invitation_status     :integer          default(0)
#
# Indexes
#
#  index_credits_on_credit_receiver_id  (credit_receiver_id)
#  index_credits_on_reel_id             (reel_id)
#  index_credits_on_reel_owner_id       (reel_owner_id)
#
