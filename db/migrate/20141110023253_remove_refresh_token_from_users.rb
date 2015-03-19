class RemoveRefreshTokenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :refresh_token
  end

  def down
    add_column :users, :refresh_token, :string
  end
end
