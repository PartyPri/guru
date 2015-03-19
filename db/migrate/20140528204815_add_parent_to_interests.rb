class AddParentToInterests < ActiveRecord::Migration
  def change
    add_column :interests,  :parent_id, :integer
  end
end
