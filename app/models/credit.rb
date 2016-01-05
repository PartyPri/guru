class Credit < ActiveRecord::Base
  attr_accessible :accepted_invitation, :credit_receiver_email, :credit_receiver_id, :reel_id, :reel_owner_id, :role

  belongs_to :reel

  validates_presence_of :credit_receiver_email, :reel_id, :reel_owner_id, :role
end
