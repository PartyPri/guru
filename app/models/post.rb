class Post < ActiveRecord::Base
  attr_accessible :caption, :user_id, :photo, :interest_ids, :activity_ids, :video_url

  #Associations

  has_many :post_interests
  has_many :interests, through: :post_interests, uniq: true

  has_many :post_activities
  has_many :activities, through: :post_activities, uniq: true

  belongs_to :user

  #Attachments
  has_attached_file :photo, :styles => {:small => "100x100>", :medium => "295x", large: "500x"},
                    :url => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
end
