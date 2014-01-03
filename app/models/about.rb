class About < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :about_interests
  has_many :interests, through: :about_interests
end
