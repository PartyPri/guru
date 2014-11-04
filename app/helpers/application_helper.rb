module ApplicationHelper
	def flash_class(type)
		case type
  		when :alert
  			"alert alert-danger"
  		when :notice
  			"alert alert-success"
  		else
  			"alert alert-danger"
		end
	end

  def share_object
    Rails.env == "production" ? reel_url(@reel) : 'https://developers.facebook.com/docs/'
  end

  
  def reel_cover_image
    if !@reel.images.empty?
      @reel.images.first.photo.url
    else
      "http://www.evrystep.herokuapp.com/assets/mighty_1.jpg"  
    end
  end

  def reel_description
    if !@reel.images.empty?
      @reel.images.first.description
    elsif !@reel.videos.empty?
      @reel.videos.first.description
    else
      "What do you rep?"
    end
  end
  
end
