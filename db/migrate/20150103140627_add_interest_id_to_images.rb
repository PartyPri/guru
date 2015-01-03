class AddInterestIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :interest_id, :integer
  end
end
