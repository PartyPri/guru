class Project < ActiveRecord::Base
  
  # Access

  attr_accessible :name, :description, :user_id, :images_attributes, :videos_attributes, :interest_ids, :cover, :_destroy

  # Associations

  belongs_to :user
  has_many :images, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :project_interests
  has_many :interests, through: :project_interests, uniq: true, after_add: :up_categories, after_remove: :down_categories

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true

  # Attachments

  has_attached_file :cover, :styles => {:small => "100x100>", :medium => "295x295#", large: "500x"},
                    :url => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  # Validations
  #validates :user, presence: true
  #validates :cover, presence: true, message: "Please choose a cover image."
  #alidates_associated :interests, message: "Please pick at least one category for your project."

  # Callback Methods

  private
  def up_categories(interest)
    if categories_hash[interest.id] == nil # if new category
      categories_hash[interest.id] = [self.id]
    else                                        # if existing category
      categories_hash[interest.id] << self.id
      categories_hash[interest.id].uniq!
    end
    self.user.save
  end

  def down_categories(interest)
    categories_hash[interest.id].delete(self.id)
    #if categories_hash[interest.id] == nil # if category is now blank, remove key from hash
    #  categories_hash.delete(interest.id)
    #end
    self.user.save
  end

  def categories_hash
    self.user.categories
  end

end
