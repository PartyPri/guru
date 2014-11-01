class AddTitleAndDescriptionToImages < ActiveRecord::Migration
  def change
    add_column :images, :title, :string
    rename_column :images, :caption, :description
  end
end
