class Video < Medium
  attr_accessible :description, :project_id, :uid

  validates_presence_of :description

  def screenshot_url
    "http://img.youtube.com/vi/#{uid}/0.jpg"
  end

  def embed_url
    "https://www.youtube.com/embed/#{uid}"
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
