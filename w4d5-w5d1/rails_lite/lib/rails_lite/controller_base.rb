require 'active_support/core_ext'
require 'erb'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

#add route params again
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @route_params = route_params
    @params = Params.new(@req, @route_params).params
  end

  def session
    @session ||= Session.new(@req)
    @session
  end

  def already_rendered?
    !!@res.body
  end

  def redirect_to(url)
    return if @already_rendered
    @res.status = '302'
    @res.header['Location'] = url.to_s
    session.store_session(@res)
    @already_rendered = already_rendered?
  end

  def render_content(content, type)
    return if @already_rendered
    @res.body = content
    @res.content_type = type
    session.store_session(@res)
    @already_rendered = already_rendered?

  end

  def render(action_name)
    url = 'views/'
    url += self.class.to_s.underscore
    url += "/"
    url += action_name.to_s
    url += '.html.erb'
    controller = ERB.new(File.read(url)).result(binding)
    render_content(controller, "text/html")
  end

  def invoke_action(name)
    send(name)
    render(name) unless already_rendered?
  end
end
