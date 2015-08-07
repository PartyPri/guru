class AddClaimEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :claim_email, :string
  end
end
