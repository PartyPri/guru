class KillOrphanedNotifications < SeedMigration::Migration
  def up
    Notification.includes(:action_taken_on).find_each(batch_size: 100) do |notification|
      destroy_for_missing_action_taken_on(notification)
      destroy_for_missing_credit(notification)
    end
  end

  def destroy_for_missing_action_taken_on(n)
    return if n.action_taken_on.present?
    log(n, :action_taken_on_type) if n.destroy
  end

  def destroy_for_missing_credit(n)
    return if n.credit_id.nil?
    return if n.credit.present?
    log(n, :credit) if n.destroy
  end

  def log(n, m)
    puts "destroyed #{n.send(m)} notification #{n.id}..."
  end

  def down
    # Do nothing because we can't un-destroy :)
  end
end
