class Medium < ActiveRecord::Base
  attr_accessible :title, :reel_id

  belongs_to :reel

  validates_presence_of :reel_id

  acts_as_taggable
end
