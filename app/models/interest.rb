class Interest < ActiveRecord::Base
  attr_accessible :name, :description, :history

  # Associations

  has_many :user_interests
  has_many :users, through: :user_interests, uniq: true

  has_many :workshop_interests
  has_many :workshops, through: :workshop_interests, uniq: true
end