class MediumMilestone < ActiveRecord::Base
  attr_accessible :medium_id, :milestone_id

  belongs_to :medium
  belongs_to :milestone
end
