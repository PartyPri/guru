class Article < ActiveRecord::Base
  attr_accessible :body, :title, :reel_id

  # Associations
  belongs_to :reel

  # Validations
  validates_presence_of :body, :title, :reel_id
end
