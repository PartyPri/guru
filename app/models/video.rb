class Video < Medium
  attr_accessible :description, :project_id, :uid

  validates_presence_of :title, :description, :uid
end
