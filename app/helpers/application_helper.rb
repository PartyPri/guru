module ApplicationHelper
	def flash_class(type)
		case type
		when :error
			"alert-danger"
		when :success
			"alert-success"
		else
			""
		end
	end
end
