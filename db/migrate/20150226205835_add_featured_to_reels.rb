class AddFeaturedToReels < ActiveRecord::Migration
  def change
    add_column :reels, :featured, :boolean
  end
end
