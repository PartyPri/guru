class Image < Medium
  attr_accessible :description, :project_id, :photo, :photo_file_name

  has_attached_file :photo, styles: {small: "100x100#", medium: "450x300#", large: "500x500#"},
                    url: "/assets/posts/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  validates_attachment_content_type :photo, :content_type => /\Aimage/
end
