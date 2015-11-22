require "csv"

class AddTagsToInterests < SeedMigration::Migration
  CSV = CSV.read("db/data/csvs/tags_by_interest_20151122.csv")

  attr_reader :action

  def up
    perform(:add)
  end

  def down
    perform(:remove)
  end

  def perform(action)
    set_action(action)
    perform_all_rows
    save_tags
  end

  def set_action(action)
    @action = action
  end

  def perform_all_rows
    CSV.each_with_index do |row, i|
      next if i.zero?
      perform_row(row)
    end
  end

  def save_tags
    interests.each do |interest|
      next if interest.nil?
      interest.save
      puts "#{interest.name} tags: #{interest.tag_list}"
    end
  end

  def perform_row(row)
    row.each_with_index do |tag, i|
      perform_tag(interests[i], tag)
    end
  end

  def perform_tag(interest, tag)
    return if tag.nil?
    return if interest.nil?
    interest.tag_list.send(action, tag.downcase)
  end

  def interests
    @interests ||= CSV[0].map do |interest_name|
      Interest.find_by_name(interest_name)
    end
  end
end
