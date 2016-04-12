class EmailContact < ActiveRecord::Base
  attr_accessible :email

  #Validations
  validates :email, uniqueness: true, on: :create
end

# == Schema Information
#
# Table name: email_contacts
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
