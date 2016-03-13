class CreateMediumMilestones < ActiveRecord::Migration
  def change
    create_table :medium_milestones do |t|
      t.integer :medium_id
      t.integer :milestone_id

      t.timestamps
    end
  end
end
