class PostActivity < ActiveRecord::Base
  attr_accessible :activity_id, :post_id

  belongs_to :post
  belongs_to :activity
end
