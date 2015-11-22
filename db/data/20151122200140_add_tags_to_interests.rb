require "csv"

class AddTagsToInterests < SeedMigration::Migration
  CSV = CSV.read("db/data/csvs/tags_by_interest_20151122.csv")

=begin
  The data structure that comes back from reading the CSV is an array of arrays like the following:

  [
    [row1col1, row1col2, row1col3],
    [row2col1, row2col2, row2col3],
    [row3col1, row3col2, row3col3],
  ]

  This code iterates through the main array to get each row, then the sub-arrays to get each column
=end

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
