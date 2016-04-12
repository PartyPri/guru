class Followership < ActiveRecord::Base
  @accessible_attrs = column_names.reject{|x| x == "id"}.map(&:to_sym)
  attr_accessible(*@accessible_attrs)
  attr_accessible :follower, :followed

  #Associations
  belongs_to :follower, class_name: "User"
  belongs_to :followed, polymorphic: true

  #Validations
  validates_uniqueness_of :follower_id, scope: [:followed_id, :followed_type], message: "Relationship already exists"


  after_create :follow_all_reels

  def reel_followership?
    followed_type == "Reel"
  end

  def user_followership?
    followed_type == "User"
  end

  private

  def follow_all_reels
    return unless user_followership?
    followed.reels.each do |reel|
      self.class.create(follower: follower, followed: reel)
    end
  end
end

# == Schema Information
#
# Table name: followerships
#
#  id            :integer          not null, primary key
#  follower_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  followed_id   :integer
#  followed_type :string(255)
#
# Indexes
#
#  index_followerships_on_followed_id_and_followed_type  (followed_id,followed_type) UNIQUE
#
