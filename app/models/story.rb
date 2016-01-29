class Story < Medium
  attr_accessible :body, :title, :photo

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    url: "/assets/posts/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  do_not_validate_attachment_file_type :photo

  validates_presence_of :body, :title, :message => "Please fill out this field"
  
  acts_as_votable

  def score
  	self.get_upvotes.size
  end

end
