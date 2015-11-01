class Reel < ActiveRecord::Base
  attr_accessible :name, :interest_ids, :images_attributes, :videos_attributes, :stories_attributes, :user_id, :tag_list, :description
  before_save :assign_featured_artist

  is_impressionable

  belongs_to :user
  has_many :reel_interests, :dependent => :destroy
  has_many :interests, through: :reel_interests, uniq: true
  has_many :media
  has_many :images
  has_many :videos
  has_many :stories
  
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true
  accepts_nested_attributes_for :stories, allow_destroy: true

  scope :featured, -> { where(featured: true) }
  scope :by_user_id, lambda{|user_id| { conditions: { user_id: user_id } } }

  acts_as_taggable

  private
    def assign_featured_artist
      if self.featured?
        self.user.featured_artist = true
        self.user.save!
      end
    end
end
