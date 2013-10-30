class CreateWorkshopInterests < ActiveRecord::Migration
  def change
    create_table :workshop_interests do |t|
      t.integer :workshop_id
      t.integer :interest_id

      t.timestamps
    end
  end
end