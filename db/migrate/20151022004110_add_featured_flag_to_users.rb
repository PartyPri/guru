class AddFeaturedFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :featured_artist, :boolean
  end
end
