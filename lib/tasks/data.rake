namespace :data do
  task migrate_media: :environment do

    Video.all.each do |v|
      video_hash = v.attributes.except("id")
      m = Medium.new(video_hash)
      m.type = "Video"
      m.save!
    end

    Image.all.each do |i|
      image_hash = i.attributes.except("id")
      m = Medium.new(image_hash)
      m.type = "Image"
      m.save!
    end

    Article.all.each do |a|
      article_hash = a.attributes.except("id")
      m = Medium.new(article_hash)
      m.type = "Article"
      m.save!
    end
  end
end
