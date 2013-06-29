module ApplicationHelper

	def notices
		flash[:notices] ||= []
	end

	def errors
		flash.now[:errors] ||= []
	end

end
