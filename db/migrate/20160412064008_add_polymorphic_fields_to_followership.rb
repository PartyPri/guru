class AddPolymorphicFieldsToFollowership < ActiveRecord::Migration
  def change
    add_column :followerships, :followed_id, :integer
    add_column :followerships, :followed_type, :string

    remove_column :followerships, :user_id

    add_index :followerships, [ :followed_id, :followed_type ], :unique => true
  end
end
