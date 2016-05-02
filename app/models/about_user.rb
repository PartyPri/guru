class AboutUser < ActiveRecord::Base

  # Associations
  belongs_to :about
  belongs_to :user
end

# == Schema Information
#
# Table name: about_users
#
#  id         :integer          not null, primary key
#  about_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
