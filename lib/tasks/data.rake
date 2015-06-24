namespace :data do
  task migrate_media: :environment do

    Image.all.each do |i|
      # include id for images so s3 association holds
      image_hash = i.attributes
      m = Medium.new(image_hash)
      m.type = "Image"
      m.save!
    end

    counter = Medium.last.id + 1

    Video.all.each do |v|
      video_hash = v.attributes.except("id")
      m = Medium.new(video_hash)
      m.type = "Video"
      m.id = counter
      counter += 1
      m.save!
    end

    Article.all.each do |a|
      article_hash = a.attributes.except("id")
      m = Medium.new(article_hash)
      m.type = "Article"
      m.id = counter
      counter += 1
      m.save!
    end

    # set media_id_seq to highest media id value so new media can be inserted
    ActiveRecord::Base.connection.execute("SELECT setval('media_id_seq', (SELECT max(id) FROM media));")
  end
end
