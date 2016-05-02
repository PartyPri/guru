class Story < Medium
  attr_accessible :body, :title, :photo

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    url: "/assets/posts/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  do_not_validate_attachment_file_type :photo

  validates_presence_of :body, :title, :message => "Please fill out this field"
  
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
#  milestone          :string(255)
#
