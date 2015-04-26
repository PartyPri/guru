class AddReelForeignKeyToImages < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.remove :reel_id

      t.integer :reel_id
    end
  end
end
