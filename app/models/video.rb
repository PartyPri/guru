class Video < ActiveRecord::Base
  attr_accessible :caption, :project_id, :url, :reel_id

  belongs_to :project
  belongs_to :reel
end
