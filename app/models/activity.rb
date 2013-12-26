class Activity < ActiveRecord::Base
  attr_accessible :name

  has_many :post_activities
  has_many :posts, through: :post_activities, uniq: true
end
