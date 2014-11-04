class UpdateVideoFieldsForYouTube < ActiveRecord::Migration
  def change 
    rename_column :videos, :caption, :description
    rename_column :videos, :url, :uid
    add_column :videos, :title, :string
  end
end
