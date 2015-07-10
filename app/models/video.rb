class Video < ActiveRecord::Base
  attr_accessible :description, :project_id, :uid, :reel_id, :title

  #Associations
  belongs_to :reel

  #Validations
  validates_presence_of :reel_id, :description

  acts_as_taggable
end
