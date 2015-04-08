class Reel < ActiveRecord::Base
  attr_accessible :name, :interest_ids, :images_attributes, :videos_attributes, :user_id, :tag_list

  #Associations
  belongs_to :user
  has_many :reel_interests, :dependent => :destroy
  has_many :interests, through: :reel_interests, uniq: true
  has_many :images
  has_many :videos
  has_many :articles
  
  #Nested Attributes
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true

  #Scopes
  scope :featured, -> { where(featured: true) }

  acts_as_taggable

  def media
    (self.images + self.videos).sort_by(&:updated_at)
  end
end
