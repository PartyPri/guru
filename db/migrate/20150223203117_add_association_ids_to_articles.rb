class AddAssociationIdsToArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.integer :reel_id
      add_column :articles, :user_id, :integer
      add_column :articles, :interest_id, :integer
    end
  end
end
