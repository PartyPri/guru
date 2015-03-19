class AboutUser < ActiveRecord::Base

  # Associations
  belongs_to :about
  belongs_to :user
end
