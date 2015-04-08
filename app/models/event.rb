class Event < ActiveRecord::Base
  attr_accessible :user_id, :date, :name, :payment_required, :time, :special_copy, :location, :description
  # The date attribute is of date_time type and is what we actually want to use. PJ is not sure how to correctly format date_time type,
  # and so is adding another attribute "time" of type string for an urgent solution. 4/2/15

  # Associations
  has_many :users, through: :registrations#, uniq: true

end
