class Image < ActiveRecord::Base
  attr_accessible :description, :project_id, :photo, :photo_file_name, :reel_id, :title

  belongs_to :project
  belongs_to :reel

  #Attachments
  has_attached_file :photo, :styles => {:small => "100x100#", :medium => "450x300#", large: "500x500#"},
                    :url => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  #Validations
  do_not_validate_attachment_file_type :photo

  validates_presence_of :reel_id
end
