class CreatePostActivities < ActiveRecord::Migration
  def change
    create_table :post_activities do |t|
      t.integer :post_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
