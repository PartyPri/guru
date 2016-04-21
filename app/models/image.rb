class Image < Medium
  attr_accessible :description, :project_id, :photo, :photo_file_name

  has_attached_file :photo, styles: {small: "100x100#", medium: "450x300#", large: "500x500#"},
                    url: "/assets/posts/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  validates_attachment_content_type :photo, :content_type => /\Aimage/

  acts_as_votable

  def score
  	self.get_upvotes.size
  end
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
#
