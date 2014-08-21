class Reel < ActiveRecord::Base
  attr_accessible :name, :interest_ids, :images_attributes

  # Associations

  belongs_to :user

  has_many :reel_interests, :dependent => :destroy
  has_many :interests, through: :reel_interests, uniq: true
  has_many :images, :dependent => :destroy

  accepts_nested_attributes_for :images, allow_destroy: true
  
end
