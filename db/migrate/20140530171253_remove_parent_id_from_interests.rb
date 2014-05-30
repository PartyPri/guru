class RemoveParentIdFromInterests < ActiveRecord::Migration
  def up
    remove_column :interests, :parent_id
  end

  def down
    add_column :interests, :parent_id, :integer
  end
end
