class AddDescriptionAndHistoryToInterests < ActiveRecord::Migration
  def change
    add_column :interests, :description, :text
    add_column :interests, :history, :text
  end
end