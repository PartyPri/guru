class AboutInterest < ActiveRecord::Base
  # attr_accessible :title, :body

  # Associations
  belongs_to :about
  belongs_to :interest
end
