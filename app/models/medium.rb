class Medium < ActiveRecord::Base
  include Notification::ActionTakenOnHelper
  attr_accessible :title, :reel_id, :milestone

  belongs_to :reel, counter_cache: true
  has_many :notifications, class_name: "Notification", foreign_key: :action_taken_on_id, dependent: :destroy

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

# == Schema Information
#
# Table name: media
#
#  id                 :integer          not null, primary key
#  description        :text
#  project_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  uid                :string(255)
#  reel_id            :integer
#  title              :string(255)
#  user_id            :integer
#  interest_id        :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  body               :text
#  type               :string(255)
#  position           :integer
#  featured_medium    :boolean
#  milestone          :string(255)
#
