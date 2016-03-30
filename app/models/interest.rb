class Interest < ActiveRecord::Base
  attr_accessible :name, :description, :history, :quote_author

  #Associations
  has_many :user_interests
  has_many :users, through: :user_interests

  has_many :reel_interests
  has_many :reels, through: :reel_interests

  has_many :images, through: :reels
  has_many :videos, through: :reels
  has_many :stories, through: :reels

  #Attachments
  has_attached_file :cover_photo, styles: { large: "1000x400#" }
  do_not_validate_attachment_file_type :cover_photo

  acts_as_taggable
end
