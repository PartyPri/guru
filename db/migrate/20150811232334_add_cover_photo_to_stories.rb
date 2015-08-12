class AddCoverPhotoToStories < ActiveRecord::Migration
  def up
    add_attachment :stories, :cover_photo
  end

  def down
    remove_attachment :stories, :cover_photo
  end
end
