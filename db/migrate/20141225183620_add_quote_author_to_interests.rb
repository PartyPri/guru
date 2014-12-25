class AddQuoteAuthorToInterests < ActiveRecord::Migration
  def change
    add_column :interests, :quote_author, :string
  end
end
