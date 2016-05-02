class About < ActiveRecord::Base

  #Associations
  has_many :about_interests
  has_many :interests, through: :about_interests
end

# == Schema Information
#
# Table name: abouts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
