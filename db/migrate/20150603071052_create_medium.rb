class CreateMedium < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.text     "description"
      t.integer  "project_id"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
      t.string   "uid"
      t.integer  "reel_id"
      t.string   "title"
      t.integer  "user_id"
      t.integer  "interest_id"
      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.datetime "photo_updated_at"
      t.text     "body"
      t.string   "type"
    end
  end
end
