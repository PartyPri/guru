class UserInterest < ActiveRecord::Base
  attr_accessible :interest_id, :user_id

  # Associations
  belongs_to :user
  belongs_to :interest

  # Validations
  validates_uniqueness_of :interest_id, scope: :user_id
end

# == Schema Information
#
# Table name: user_interests
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  interest_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
