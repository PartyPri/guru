class About < ActiveRecord::Base

  #Associations
  has_many :about_interests
  has_many :interests, through: :about_interests
end
