class Followership < ActiveRecord::Base

  attr_accessible :follower_id, :user_id

  #Associations
  belongs_to :user
  belongs_to :follower, class_name: "User"

  #Validations
  validates_uniqueness_of :follower_id, scope: :user_id, message: "Relationship already exists"
end
