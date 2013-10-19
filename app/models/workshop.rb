class Workshop < ActiveRecord::Base
  attr_accessible :description, :title

  # Associations

  has_many :workshop_interests
  has_many :interests, through: :workshop_interests, uniq: true
end