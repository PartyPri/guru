class AboutInterest < ActiveRecord::Base

  #Associations
  belongs_to :about
  belongs_to :interest
end

# == Schema Information
#
# Table name: about_interests
#
#  id          :integer          not null, primary key
#  about_id    :integer
#  interest_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
