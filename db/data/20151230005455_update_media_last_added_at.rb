class UpdateMediaLastAddedAt < SeedMigration::Migration
  def up
    Reel.includes(:media).where(media_last_added_at: nil).find_each do |reel|
      update_reel(reel)
    end
  end

  def update_reel(reel)
    return if reel.media.empty?
    sorted_media = reel.media.sort_by(&:created_at)
    result = reel.update_column(:media_last_added_at, sorted_media.last.created_at)
    puts "Updated #{reel.id}" if result
  end

  def down
    result = Reel.update_all(media_last_added_at: nil)
    puts "Updated #{result} Reels"
  end
end
