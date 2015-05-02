class AddClaimTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :claim_token, :string
  end
end
