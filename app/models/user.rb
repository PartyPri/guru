class User < ActiveRecord::Base

  # Devise

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  # Access

  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :first_name, :last_name, :description, :avatar, :location, :interest_ids,
    :uid, :provider

  # Serialize

  serialize :categories, Hash

  # Associations

  has_many :user_interests
  has_many :interests, through: :user_interests, uniq: true
  has_many :workshops
  has_many :posts
  has_many :projects#, inverse_of: :user
  has_many :reels

  has_many :followerships, dependent: :destroy
  has_many :followers, through: :followerships

  # Attachments
  
  has_attached_file :avatar, :styles => {:small => "140x140#", :medium => "250x250#"}, :default_url => "http://s3.amazonaws.com/evrystep-assets/users/avatars/default/small/missing.png" #{}"/system/users/avatars/default/small/missing.png" 
  
  # Validations

  validates_presence_of :first_name, :last_name#, :location, :description

  do_not_validate_attachment_file_type :avatar

  # Methods

  #Google Authentication
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    #create new user if user does not exist
    unless user
        user = User.create(first_name: data["first_name"], 
          last_name: data["last_name"],
          email: data["email"],
          password: Devise.friendly_token[0,20]
          )
    end
    user
  end


  def followed_users #refactor to use built in rails associations
    Followership.all.map { |followership|
      if followership.follower_id == self.id
        User.find(followership.user_id)
      end
    }.delete_if {|x| x == nil}
  end
end