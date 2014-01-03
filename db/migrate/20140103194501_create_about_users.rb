class CreateAboutUsers < ActiveRecord::Migration
  def change
    create_table :about_users do |t|
      t.integer :about_id
      t.integer :user_id

      t.timestamps
    end
  end
end
