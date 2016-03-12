class Reel < ActiveRecord::Base
  attr_accessible :name, :interest_ids, :images_attributes, :videos_attributes, :stories_attributes,
    :user_id, :tag_list, :description, :media_last_added_at
  before_save :assign_featured_artist

  is_impressionable

  belongs_to :user
  has_many :reel_interests, :dependent => :destroy
  has_many :interests, through: :reel_interests, uniq: true
  has_many :media
  has_many :images
  has_many :videos
  has_many :stories
  has_many :credits, :dependent => :destroy

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true
  accepts_nested_attributes_for :stories, allow_destroy: true

  scope :featured, -> { where(featured: true) }
  scope :by_user_id, lambda{|user_id| { conditions: { user_id: user_id } } }
  scope :with_enough_media, -> { where("media_count > 2") }
  scope :recently_added_media, -> { order("media_last_added_at desc") }

  acts_as_taggable

  def update_media_added!
    update_attributes(media_last_added_at: Time.now)
  end

  def reference_title
    name
  end

  private
    def assign_featured_artist
      if self.featured?
        self.user.featured_artist = true
        self.user.save!
      end
    end
end
