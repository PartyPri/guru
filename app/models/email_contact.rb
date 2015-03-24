class EmailContact < ActiveRecord::Base
  attr_accessible :email

  #Validations
  validates :email, uniqueness: true, on: :create
end
