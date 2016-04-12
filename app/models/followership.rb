class Followership < ActiveRecord::Base

  attr_accessible :follower_id, :user_id

  #Associations
  belongs_to :user
  belongs_to :follower, class_name: "User"

  #Validations
  validates_uniqueness_of :follower_id, scope: :user_id, message: "Relationship already exists"
end

# == Schema Information
#
# Table name: followerships
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  follower_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  followed_id   :integer
#  followed_type :string(255)
#
