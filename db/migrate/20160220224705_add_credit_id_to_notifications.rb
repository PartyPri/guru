class AddCreditIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :credit_id, :integer
  end
end
