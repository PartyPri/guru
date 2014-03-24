class Image < ActiveRecord::Base
  attr_accessible :caption, :project_id, :photo, :photo_file_name

  belongs_to :project

  #Attachments
  has_attached_file :photo, :styles => {:small => "100x100>", :medium => "295x", large: "500x"},
                    :url => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
end
