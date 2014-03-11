class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :caption
      t.integer :project_id

      t.timestamps
    end
  end
end
