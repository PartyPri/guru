class AddInterestIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :interest_id, :integer
  end
end
