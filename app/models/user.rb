class User < ActiveRecord::Base

  # Devise

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Access

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  # Associations

  has_many :user_interests
  has_many :interests, through: :user_interests, uniq: true
  has_many :workshops

  # Validations

  validates :first_name, presence: true
  validates :last_name, presence: true
end