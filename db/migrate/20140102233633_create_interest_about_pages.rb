class CreateInterestAboutPages < ActiveRecord::Migration
  def change
    create_table :interest_about_pages do |t|

      t.timestamps
    end
  end
end
