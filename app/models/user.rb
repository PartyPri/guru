class User < ActiveRecord::Base

  # Devise

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Access

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :description, :avatar

  # Associations

  has_many :user_interests
  has_many :interests, through: :user_interests, uniq: true
  has_many :workshops
  has_many :posts

  has_many :followerships, dependent: :destroy
  has_many :followers, through: :followerships

  # Attachments
  
  has_attached_file :avatar, :styles => {:small => "150x"}, :default_url => "http://s3.amazonaws.com/evrystep-assets/users/avatars/missing.png"

  # Validations

  validates :first_name, presence: true
  validates :last_name, presence: true

  def followed_users #refactor to use built in rails associations
    Followership.all.map { |followership|
      if followership.follower_id == self.id
        User.find(followership.user_id)
      end
    }.delete_if {|x| x == nil}
  end
end