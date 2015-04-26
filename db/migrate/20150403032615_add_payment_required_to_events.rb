class AddPaymentRequiredToEvents < ActiveRecord::Migration
  def change
    add_column :events, :payment_required, :boolean
  end
end
