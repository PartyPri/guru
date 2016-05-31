class Video < Medium
  attr_accessible :description, :project_id, :uid



  def screenshot_url
    "http://img.youtube.com/vi/#{uid}/0.jpg"
  end

  def embed_url
    "https://www.youtube.com/embed/#{uid}"
  end
end
