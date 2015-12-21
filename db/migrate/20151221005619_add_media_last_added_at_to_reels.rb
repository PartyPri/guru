class AddMediaLastAddedAtToReels < ActiveRecord::Migration
  def change
    add_column :reels, :media_last_added_at, :datetime
  end
end
