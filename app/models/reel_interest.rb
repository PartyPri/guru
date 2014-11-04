class ReelInterest < ActiveRecord::Base
  attr_accessible :reel_id, :interest_id

  belongs_to :reel
  belongs_to :interest
end
