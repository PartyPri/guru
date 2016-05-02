class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :action
      t.integer :followed_user_id
      t.integer :item_id
      t.string  :item_type
      t.timestamps
    end
  end
end
