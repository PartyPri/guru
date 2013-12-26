class PostInterest < ActiveRecord::Base
  attr_accessible :interest_id, :post_id

  belongs_to :post
  belongs_to :interest
end
