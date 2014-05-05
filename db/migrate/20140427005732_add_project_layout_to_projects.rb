class AddProjectLayoutToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_layout, :string
  end
end
