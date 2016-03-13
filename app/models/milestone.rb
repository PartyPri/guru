class Milestone < ActiveRecord::Base
  attr_accessible :title

  belongs_to :medium
end
