require 'json'
require 'webrick'

class Session
  def initialize(req)
  	@req = req
  	@req.cookies.each do |cookie|
  		@rails_lite_app = JSON.parse(cookie) if cookie == '_rails_lite_app'
  	end
  	@rails_lite_app ||= {}
  end

  def [](key)
  	@rails_lite_app[key]
  end

  def []=(key, val)
  	@rails_lite_app[key] = val
  end

  def store_session(res)
  	cookie = WEBrick::Cookie.new('_rails_lite_app', @rails_lite_app.to_json)
  	res.cookies << cookie
  end
end
