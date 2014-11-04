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
    Rails.env == "production" ? request.original_url : 'https://developers.facebook.com/docs/'
  end
  
end
