class Story < Medium
  attr_accessible :body

  validates_presence_of :body, :title
end
