class AddClaimUserFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :claim_user, :boolean
  end
end
