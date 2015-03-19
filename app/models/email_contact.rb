class EmailContact < ActiveRecord::Base
  attr_accessible :email

<<<<<<< HEAD
  validates :email, uniqueness: true, on: :create
end
=======
  #Validations
  validates :email, uniqueness: true, on: :create
end
>>>>>>> develop
