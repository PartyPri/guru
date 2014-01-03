class AboutUser < ActiveRecord::Base
  # attr_accessible :title, :body

  # Associations
  belongs_to :about
  belongs_to :user
end
