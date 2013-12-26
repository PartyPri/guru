class CreatePostInterests < ActiveRecord::Migration
  def change
    create_table :post_interests do |t|
      t.integer :post_id
      t.integer :interest_id

      t.timestamps
    end
  end
end
