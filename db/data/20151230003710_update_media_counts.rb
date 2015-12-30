class UpdateMediaCounts < SeedMigration::Migration
  def up
    Reel.find_each do |reel|
      result = Reel.reset_counters(reel.id, :media)
      puts "Updated #{reel.id}" if result
    end
  end

  def down
    count = Reel.update_all(media_count: 0)
    puts "Updated #{count} Reels"
  end
end
