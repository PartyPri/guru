class ProjectInterest < ActiveRecord::Base
  attr_accessible :project_id, :interest_id

  belongs_to :project
  belongs_to :interest

  # after_save :up_categories
  # after_destroy :down_categories

  # I had to call down_categories method in project.rb and in project_interest.rb b/c the project version doesn't
  # work when a project is deleted, and the project_interest.rb callback doesn't work when a project is updated. Argh.
  # The up_categories callback needs to be in this document b/c it doesn't work on project.rb since user=nil until saved
  # and the only available appropriate association callback for use is after_add. 

  # def up_categories

  #   categories = self.project.user.categories
  #   interest_id = self.interest.id
  #   project_id = self.project.id
  #   user = self.project.user

  #   if categories[interest_id] == nil # if new category
  #     categories[interest_id] = [project_id]
  #   else                                        # if existing category
  #     categories[interest_id] << project_id
  #     categories[interest_id].uniq!
  #   end
  #   user.save
  # end

  # def down_categories

  #   categories = self.project.user.categories
  #   interest_id = self.interest.id
  #   project_id = self.project.id
  #   user = self.project.user

  #   categories[interest_id].delete(project_id)
  #   if categories[interest_id] == [] # if category is now blank, remove key from hash
  #     categories.delete(interest_id)
  #   end
  #   user.save
  # end
end
