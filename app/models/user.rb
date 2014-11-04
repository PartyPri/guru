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
    :uid, :provider, :token, :refresh_token, :expires_at

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

    unless user
      user = User.create(first_name: data["first_name"], 
        last_name: data["last_name"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        provider: access_token.provider,
        uid: access_token.uid,
        token: access_token.credentials.token,
        refresh_token: access_token.credentials.refresh_token,
        expires_at: Time.at(access_token.credentials.expires_at)
      )
    end
    user
  end

  #Using oauth2 refresh logic ?
  def refresh_token_if_expired
    self.access_token = access_token.refresh! if access_token.expired?
  end

  #Refreshes the Google user token if it is expired. Note: expires approximately 1 hr after granting.
  # def refresh_token_if_expired
  #   if token_expired?
  #     response = RestClient.post "#{ENV['DOMAIN']}oauth2/token", :grant_type => 'refresh_token', :refresh_token => self.refresh_token, :client_id => ENV['GOOGLE_CLIENT_ID'], :client_secret => ENV['GOOGLE_CLIENT_SECRET'] 
  #     refreshed_hash = JSON.parse(response.body)
  #     self.token     = refreshed_hash['access_token']
  #     debugger
  #     self.expires_at = DateTime.now + refresh_hash["expires_in"].to_i.seconds

  #     self.save
  #     puts 'Saved'
  #   end
  # end

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