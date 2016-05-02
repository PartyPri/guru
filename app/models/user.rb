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
  has_many :reels, dependent: :destroy
  has_many :images, through: :reels
  has_many :videos, through: :reels
  has_many :stories, through: :reels

  has_many :followerships, dependent: :destroy

  has_many :registrations
  has_many :events, through: :registrations, uniq: true
  has_many :credits, through: :reels
  has_many :notifications, class_name: "Notification", foreign_key: :receiver_id, dependent: :destroy


  acts_as_voter

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
    self.first_name = claim_user.first_name
    self.last_name = claim_user.last_name
    self.cover_photo = claim_user.cover_photo
    self.avatar = claim_user.avatar
    if claim_user.reels.any?
      self.reels = claim_user.reels
    end

    self.save!
    claim_user.destroy
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

  def already_following?(followed)
    num = Followership.where(
      follower_id: self.id,
      followed_id: followed.id,
      followed_type: followed.class.name
    ).count

    !num.zero?
  end

  # Get a list of users that follow the user
  def followers
    self.class.joins("INNER JOIN followerships ON followerships.follower_id = users.id")
      .where("followerships.followed_id = #{self.id} and followed_type = 'User'")
  end

  # Get a list of users that the user is following
  def followed_users
    self.class.joins("INNER JOIN followerships ON followerships.followed_id = users.id")
      .where("followerships.follower_id = #{self.id} and followed_type = 'User'")
  end

  def followed_reels
    Reel.joins("INNER JOIN followerships ON followerships.followed_id = reels.id")
      .where("followerships.follower_id = #{self.id} and followed_type = 'Reel'")
  end

  def entourage
    Credit.by_reel_owner(id).accepted
  end

  def reference_title
    first_name
  end
end

# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string(255)      default(""), not null
#  encrypted_password       :string(255)      default(""), not null
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0)
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  first_name               :string(255)
#  last_name                :string(255)
#  description              :text
#  avatar_file_name         :string(255)
#  avatar_content_type      :string(255)
#  avatar_file_size         :integer
#  avatar_updated_at        :datetime
#  categories               :text
#  location                 :string(255)
#  provider                 :string(255)
#  uid                      :string(255)
#  token                    :string(255)
#  expires_at               :datetime
#  bio                      :text
#  cover_photo_file_name    :string(255)
#  cover_photo_content_type :string(255)
#  cover_photo_file_size    :integer
#  cover_photo_updated_at   :datetime
#  claim_token              :string(255)
#  claim_email              :string(255)
#  claim_user               :boolean
#  featured_artist          :boolean
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
