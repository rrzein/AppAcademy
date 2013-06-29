require 'uri'

class Params
  attr_reader :params

  def initialize(req, route_params)
    @req = req
    @params = route_params
    parse_www_encoded_form(req.query_string) if req.query_string
    parse_www_encoded_form(req.body) if req.body
    # @params += parse_www_encoded_form(req.body) if req.body
  end

  def [](key)
    @params[key]
  end

  def to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    params = {}
    URI.decode_www_form(www_encoded_form).each do |topkey, value|
      keypath = parse_key(topkey)
      toplevel = nil
      keypath.each_with_index do |key, index|
        toplevel = key if index == 0
        next if index == 0
        if index < keypath.count - 1
          params[key] ||= {}
          # params = params[key]
        else
          params[key] = value
        end
       end
      @params[toplevel] = params
    end
  end

  def parse_key(key)
    unless key =~ /[\[\]]/
      [key]
    else
      /(?<head>.*)\[(?<rest>.*)\]/ =~ key
      heads = parse_key(head)
      heads << rest
    end
  end
end
