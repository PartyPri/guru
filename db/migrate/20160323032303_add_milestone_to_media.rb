class AddMilestoneToMedia < ActiveRecord::Migration
  def change
    add_column :media, :milestone, :string
  end
end
