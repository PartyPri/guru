class AddAttachmentCoverPhotoToInterests < ActiveRecord::Migration
  def self.up
    change_table :interests do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    drop_attached_file :interests, :cover_photo
  end
end
