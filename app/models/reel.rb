class Reel < ActiveRecord::Base
  attr_accessible :name

  # Associations

  belongs_to :user
  
end
