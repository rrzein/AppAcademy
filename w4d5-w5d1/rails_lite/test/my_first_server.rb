require 'webrick'
load './lib/rails_lite/controller_base.rb'

#do we need document root here?
server = WEBrick::HTTPServer.new :Port => 8000

trap('INT') { server.shutdown }

server.mount_proc '/' do |req, resp|
	resp.content_type = 'text/text'
	resp.body = 'localhost'
end

server.start

class MyController < ControllerBase

	def go
		case @req.request_line
		when 'GET /redirect HTTP1.1'
			redirect_to('www.google.com')
		when 'GET /render?content=content-goes-here'
			query_string(@req.request_line)
		end
	end
end

