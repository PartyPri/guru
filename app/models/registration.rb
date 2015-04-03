class Registration < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :user_id, :event_id, :availability_confirmation, :payment_required

  # Associations
  belongs_to :event
  belongs_to :user

  # Validations
  validates :availability_confirmation, :acceptance => {:message => "You must confirm that you are available for the event."}

end
