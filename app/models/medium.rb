class Medium < ActiveRecord::Base
  attr_accessible :title, :reel_id

  belongs_to :reel, counter_cache: true

  validates_presence_of :reel_id

  acts_as_taggable
  acts_as_list scope: :reel, add_new_at: :top

  after_save :update_reel_media_added

  def update_reel_media_added
    return unless reel
    reel.update_media_added!
  end

  acts_as_votable

  def score
  	self.get_upvotes.size
  end

  def user
    reel.user
  end

  def reference_title
    return title if is_a?(Story)
    description
  end

  acts_as_commentable
end
