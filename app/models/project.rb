class Project < ActiveRecord::Base
  
  # Access

  attr_accessible :name, :description, :user_id, :images_attributes, :videos_attributes, :interest_ids, :cover, :_destroy

  # Associations

  belongs_to :user
  has_many :images, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :project_interests, :dependent => :destroy
  has_many :interests, through: :project_interests, uniq: true, after_remove: :down_categories#, after_add: :up_categories, after_remove: :down_categories

  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => lambda {|a| a[:photo].blank?}
  accepts_nested_attributes_for :videos, allow_destroy: true, :reject_if => proc { |attributes| attributes['url'].blank? }

  # Attachments

  has_attached_file :cover, :styles => {:small => "100x100>", :medium => "295x295#", large: "500x"},
                    :url => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  # Validations
  #validates :user, presence: true
  #validates :cover, presence: true, message: "Please choose a cover image."
  #alidates_associated :interests, message: "Please pick at least one category for your project."

  # Callback Methods

  # def up_categories(interest)
  #   if self.user.categories[interest.id] == nil # if new category
  #     self.user.categories[interest.id] = [self.id]
  #   else                                        # if existing category
  #     self.user.categories[interest.id] << self.id
  #     self.user.categories[interest.id].uniq!
  #   end
  #   self.user.save
  # end

  # I had to call down_categories method in project.rb and in project_interest.rb b/c the project version doesn't
  # work when a project is deleted, and the project_interest.rb callback doesn't work when a project is updated. Argh.
  # The up_categories callback needs to be in this document b/c it doesn't work on project.rb since user=nil until saved
  # and the only available appropriate association callback for use is after_add. 
  
  def down_categories(interest)

    categories = self.user.categories
    interest_id = interest.id
    project_id = self.id
    user = self.user
      
    categories[interest_id].delete(project_id)
    if categories[interest_id] == [] # if category is now blank, remove key from hash
      categories.delete(interest_id)
    end
    user.save
  end

end
