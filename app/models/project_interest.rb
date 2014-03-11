class ProjectInterest < ActiveRecord::Base
  attr_accessible :project_id, :interest_id

  belongs_to :project
  belongs_to :interest
end
