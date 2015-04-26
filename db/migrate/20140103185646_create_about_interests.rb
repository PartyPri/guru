class CreateAboutInterests < ActiveRecord::Migration
  def change
    create_table :about_interests do |t|
      t.integer :about_id
      t.integer :interest_id

      t.timestamps
    end
  end
end
