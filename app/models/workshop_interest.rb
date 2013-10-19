class WorkshopInterest < ActiveRecord::Base
  attr_accessible :interest_id, :workshop_id

  belongs_to :workshop
  belongs_to :interest
end
