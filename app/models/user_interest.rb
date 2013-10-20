class UserInterest < ActiveRecord::Base
  attr_accessible :interest_id, :user_id

  # Associations
  belongs_to :user
  belongs_to :interest

  # Validations
  validates_uniqueness_of :interest_id, scope: :user_id
end