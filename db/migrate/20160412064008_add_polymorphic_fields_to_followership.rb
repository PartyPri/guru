class AddPolymorphicFieldsToFollowership < ActiveRecord::Migration
  def change
    add_column :followerships, :followed_id, :integer
    add_column :followerships, :followed_type, :string
  end
end
