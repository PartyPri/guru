class AddCategoriesToUser < ActiveRecord::Migration
  def change
    add_column :users, :categories, :text
  end
end
