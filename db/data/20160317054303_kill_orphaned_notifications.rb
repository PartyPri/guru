class KillOrphanedNotifications < SeedMigration::Migration
  def up
    Notification.includes(:action_taken_on).find_each(batch_size: 100) do |notification|
      next if notification.action_taken_on.present?
      log(n) if notification.destroy
    end
  end

  def log(n)
    puts "destroyed #{n.action_taken_on_type} notification #{n.id}..."
  end

  def down
    # Do nothing because we can't un-destroy :)
  end
end
