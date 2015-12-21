class AddMediaCountToReel < ActiveRecord::Migration
  def change
    add_column :reels, :media_count, :integer, default: 0
  end
end
