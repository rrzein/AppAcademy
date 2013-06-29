module ApplicationHelper

	def notices
		flash[:notices] ||= []
	end

	def errors
		flash[:errors] ||= []
	end

	def all_papers
		Newspaper.all
	end

end
