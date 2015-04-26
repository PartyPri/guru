class AddReelIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :reel_id, :integer
  end
end
