class RemoveMiddleNameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :middle_name
  end

  def down
    add_column :users, :middle_name, :string
  end
end
