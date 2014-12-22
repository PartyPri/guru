class Interest < ActiveRecord::Base
  attr_accessible :name, :description, :history

  # Associations

  #has_many :subinterests, :class_name => "Interest", :foreign_key => "parent_id"
  #belongs_to :parent_interest, :class_name => "Interest"

  has_many :user_interests
  has_many :users, through: :user_interests, uniq: true

  has_one :about_interest
  has_one :about, through: :about_interest

  has_many :reel_interests
  has_many :reels, through: :reel_interests, uniq: true
end