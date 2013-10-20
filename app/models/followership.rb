class Followership < ActiveRecord::Base

  attr_accessible :follower_id

  belongs_to :user
  belongs_to :follower, class_name: "User"

  validates_uniqueness_of :follower_id, scope: :user_id, message: "Relationship already exists"

end