class AddUserIdToReels < ActiveRecord::Migration
  def change
    add_column :reels, :user_id, :integer
  end
end
