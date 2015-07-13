class AddOrderIdsToReels < ActiveRecord::Migration
  def change
    add_column :reels, :order_ids, :integer
  end
end
