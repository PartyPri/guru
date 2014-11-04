class AddReelIdToVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.integer :reel_id
    end
  end
end
