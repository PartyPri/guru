class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.integer :action, default: 0
      t.integer :receiver_id
      t.integer :action_taker_id
      t.integer :action_taken_on_id
      t.string  :action_taken_on_type

      t.timestamps
    end
  end
end
