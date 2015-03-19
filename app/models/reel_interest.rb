class ReelInterest < ActiveRecord::Base
  attr_accessible :reel_id, :interest_id

  #Associations
  belongs_to :reel
  belongs_to :interest
end
