class Video < ActiveRecord::Base
  attr_accessible :description, :project_id, :uid, :reel_id, :title

  belongs_to :project
  belongs_to :reel

  validates_presence_of :reel_id, :title, :description, :uid
end
