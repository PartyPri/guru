class Project < ActiveRecord::Base
  attr_accessible :name, :description, :user_id, :images_attributes, :videos_attributes, :interest_ids, :cover, :_destroy

  belongs_to :user
  has_many :images
  has_many :videos
  has_many :project_interests
  has_many :interests, through: :project_interests, uniq: true

  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => lambda { |t| t['image'].nil? }
  accepts_nested_attributes_for :videos, allow_destroy: true, :reject_if => lambda { |t| t['video'].nil? }

  #Attachments
  has_attached_file :cover, :styles => {:small => "100x100>", :medium => "295x295#", large: "500x"},
                    :url => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  #Validations
  #validates :user, presence: true
  #validates :cover, presence: true, message: "Please choose a cover image."
  #alidates_associated :interests, message: "Please pick at least one category for your project."

end
