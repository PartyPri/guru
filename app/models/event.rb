class Event < ActiveRecord::Base
  attr_accessible :date, :name

  # Associations
  has_many :users, through: :registrations, uniq: true
end
