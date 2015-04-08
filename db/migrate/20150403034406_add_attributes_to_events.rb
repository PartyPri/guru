class AddAttributesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time, :string
    add_column :events, :special_copy, :string
    add_column :events, :location, :string
    add_column :events, :description, :string
  end
end
