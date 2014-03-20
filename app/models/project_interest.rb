class ProjectInterest < ActiveRecord::Base
  attr_accessible :project_id, :interest_id

  belongs_to :project
  belongs_to :interest

  after_save :up_categories
  after_destroy :down_categories

  # I had to call down_categories method in project.rb and in project_interest.rb b/c the project version doesn't
  # work when a project is deleted, and the project_interest.rb callback doesn't work when a project is updated. Argh.
  # The up_categories callback needs to be in this document b/c it doesn't work on project.rb since user=nil until saved
  # and the only available appropriate association callback for use is after_add. 

  def up_categories
    if self.project.user.categories[self.interest.id] == nil # if new category
      self.project.user.categories[self.interest.id] = [self.project.id]
    else                                        # if existing category
      self.project.user.categories[self.interest.id] << self.project.id
      self.project.user.categories[self.interest.id].uniq!
    end
    self.project.user.save
  end

  def down_categories
    self.project.user.categories[self.interest.id].delete(self.project.id)
    #if self.user.categories[interest.id] == nil # if category is now blank, remove key from hash
    #  self.user.categories.delete(interest.id)
    #end
    self.project.user.save
  end
end
