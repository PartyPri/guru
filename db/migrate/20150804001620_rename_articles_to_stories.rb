class RenameArticlesToStories < ActiveRecord::Migration
  def up
    rename_table :articles, :stories
  end

  def down
    rename_table :stories, :articles
  end
end
