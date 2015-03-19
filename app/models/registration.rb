class Registration < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :user_id, :event_id

  # Associations
  belongs_to :event
  belongs_to :user

end
