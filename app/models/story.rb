class Story < Medium
  attr_accessor :cover_photo_file_name
  attr_accessible :body, :title, :cover_photo
  
  has_attached_file :cover_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  do_not_validate_attachment_file_type :cover_photo

  validates_presence_of :body, :title

end
