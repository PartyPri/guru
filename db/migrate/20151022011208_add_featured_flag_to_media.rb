class AddFeaturedFlagToMedia < ActiveRecord::Migration
  def change
    add_column :media, :featured_medium, :boolean
  end
end
