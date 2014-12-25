class Interest < ActiveRecord::Base
  attr_accessible :name, :description, :history, :quote_author

  # Associations

  #has_many :subinterests, :class_name => "Interest", :foreign_key => "parent_id"
  #belongs_to :parent_interest, :class_name => "Interest"

  has_many :user_interests
  has_many :users, through: :user_interests, uniq: true

  has_one :about_interest
  has_one :about, through: :about_interest

  has_many :reel_interests
  has_many :reels, through: :reel_interests, uniq: true

  # Attachments
  
  has_attached_file :cover_photo, :styles => {:large => "1000x400#"}
  do_not_validate_attachment_file_type :cover_photo

end