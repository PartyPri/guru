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

  def share_object(type)
    if Rails.env != "production" 
      'https://developers.facebook.com/docs/'
    else
      case type
        when 'reel'
          reel_url(@reel) 
        when 'user'
          user_url(@user)
        else 
          'https://developers.facebook.com/docs/'
      end
    end
  end
  
  def reel_cover_image
    if !@reel.images.empty?
      @reel.images.first.photo.url
    else
      "http://evrystep.herokuapp.com/assets/mighty_1.jpg"  
    end
  end

  def user_image
    @user.avatar ? @user.avatar.url : "http://evrystep.herokuapp.com/assets/mighty_1.jpg"  
  end

  def user_description
    @user.description || "What do you rep?"
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
