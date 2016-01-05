class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :reel_id
      t.integer :reel_owner_id
      t.integer :credit_receiver_id
      t.boolean :accepted_invitation, default: false
      t.string :role
      t.string :credit_receiver_email
      t.timestamps
    end

    add_index :credits, :reel_owner_id
    add_index :credits, :credit_receiver_id
    add_index :credits, :reel_id
  end
end
