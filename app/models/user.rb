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
    :first_name, :last_name, :description, :bio, :cover_photo, :avatar, :location, :interest_ids,
    :uid, :provider, :token, :refresh_token, :expires_at, :claim_token, :claim_email

  # Associations

  has_many :user_interests
  has_many :interests, through: :user_interests, uniq: true
  has_many :reels
  has_many :images, through: :reels
  has_many :videos, through: :reels
  has_many :articles, through: :reels

  has_many :followerships, dependent: :destroy
  has_many :followers, through: :followerships

  has_many :registrations
  has_many :events, through: :registrations, uniq: true

  # Attachments
  
  has_attached_file :avatar, :styles => {:small => "140x140#", :medium => "250x250#"}, :default_url => "http://s3.amazonaws.com/evrystep-assets/users/avatars/default/small/missing.png"
  has_attached_file :cover_photo, :styles => {:medium => "500x200#", :large => "1000x400#"}, :default_url => "https://s3.amazonaws.com/evrystep-assets/users/cover_photos/default/default_cover_photo.jpg"
  
  # Validations

  validates_presence_of :first_name, :last_name#, :location, :description

  do_not_validate_attachment_file_type :avatar
  do_not_validate_attachment_file_type :cover_photo

  # Methods

  #Update claim user attributes
  def update_claim_attributes(token, claim_user)
    self.claim_token = token
    self.first_name = claim_user.first_name
    self.last_name = claim_user.last_name
    self.cover_photo = claim_user.cover_photo
    self.reels = claim_user.reels
    self.save!
  end

  #Google Authentication
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    
    if user
      user.update_attributes(token: access_token.credentials.token, 
        expires_at: Time.at(access_token.credentials.expires_at))
    else
      user = User.create(first_name: data["first_name"], 
        last_name: data["last_name"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        provider: access_token.provider,
        uid: access_token.uid,
        token: access_token.credentials.token,
        expires_at: Time.at(access_token.credentials.expires_at)
      )
    end
    user
  end

  def token_expired?
    self.expires_at < Time.now
  end

  def followed_users #refactor to use built in rails associations
    Followership.all.map { |followership|
      if followership.follower_id == self.id
        User.find(followership.user_id)
      end
    }.delete_if {|x| x == nil}
  end
end
