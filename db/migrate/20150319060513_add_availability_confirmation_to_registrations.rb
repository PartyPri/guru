class AddAvailabilityConfirmationToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :availability_confirmation, :boolean
  end
end
