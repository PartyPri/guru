class ReelInterest < ActiveRecord::Base
  attr_accessible :reel_id, :interest_id

  #Associations
  belongs_to :reel
  belongs_to :interest
end

# == Schema Information
#
# Table name: reel_interests
#
#  id          :integer          not null, primary key
#  reel_id     :integer
#  interest_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
