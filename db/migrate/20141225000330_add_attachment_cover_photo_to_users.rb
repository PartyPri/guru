class AddAttachmentCoverPhotoToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    drop_attached_file :users, :cover_photo
  end
end
