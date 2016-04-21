class Interest < ActiveRecord::Base
  attr_accessible :name, :description, :history, :quote_author

  #Associations
  has_many :user_interests
  has_many :users, through: :user_interests, uniq: true

  has_many :reel_interests
  has_many :reels, through: :reel_interests, uniq: true

  has_many :images, through: :reels
  has_many :videos, through: :reels
  has_many :stories, through: :reels

  #Attachments
  has_attached_file :cover_photo, styles: { large: "1000x400#" }
  do_not_validate_attachment_file_type :cover_photo

  acts_as_taggable
end

# == Schema Information
#
# Table name: interests
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  description              :text
#  history                  :text
#  cover_photo_file_name    :string(255)
#  cover_photo_content_type :string(255)
#  cover_photo_file_size    :integer
#  cover_photo_updated_at   :datetime
#  quote_author             :string(255)
#
