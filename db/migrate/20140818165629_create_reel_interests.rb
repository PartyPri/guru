class CreateReelInterests < ActiveRecord::Migration
  def change
    create_table :reel_interests do |t|
      t.integer :reel_id
      t.integer :interest_id

      t.timestamps
    end
  end
end
