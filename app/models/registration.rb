class Registration < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :user_id, :event_id, :availability_confirmation

  # Associations
  belongs_to :event
  belongs_to :user

  # Validations
  validates :availability_confirmation, :acceptance => {:message => "You must confirm that you are available for the event."}
  validates :name, :email, length: {maximum: 50, message: "is too long"}
  validates :phone, length: {maximum: 20, message: "is too long"}
  validates :name, :email, :phone, :presence => {:message => "cannot be blank"}

end
