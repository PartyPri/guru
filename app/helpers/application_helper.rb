module ApplicationHelper

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

  def reel_image
    if @reel.images.any?
      @reel.images.last.photo
    else
      @user.avatar
    end
  end

  def last_reel_medium
    if @reel.media.any?
      if @reel.media.last.is_a? Image
        "#{root_url}#{@reel.images.last.photo}"
      else
        "http://www.youtube.com/v/#{@reel.media.last.uid}"
      end
    else
      @user.avatar
    end
  end

  def user_image
    @user.avatar ? @user.avatar.url : "http://evrystep.herokuapp.com/assets/mighty_1.jpg"
  end

  def user_description
    @user.description || "What do you rep?"
  end

  def reel_description
    if @reel.description.empty?
      "What do you rep?"
    else
      @reel.description
    end
  end
  
end
