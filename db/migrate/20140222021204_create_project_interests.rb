class CreateProjectInterests < ActiveRecord::Migration
  def change
    create_table :project_interests do |t|
      t.integer :project_id
      t.integer :interest_id

      t.timestamps
    end
  end
end
