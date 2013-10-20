class EmailContact < ActiveRecord::Base
  attr_accessible :email

  validates :email, uniqueness: true, on: :create
end