class Video < ActiveRecord::Base
  attr_accessible :caption, :project_id, :url

  belongs_to :project
end
