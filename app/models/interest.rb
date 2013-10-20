class Interest < ActiveRecord::Base
  attr_accessible :name

  has_many :user_interests
  has_many :users, through: :user_interests, uniq: true
end