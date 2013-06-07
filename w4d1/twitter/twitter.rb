require 'launchy'
require 'rest-client'
require 'oauth'
require 'addressable/uri'
require 'yaml'
require 'json'

class TwitterSession

	CONSUMER_KEY = "BmY4X2tKeJHN9A8L3JIwg"
	CONSUMER_SECRET = "inZdql3WMVrfEzLhsJcHAyZ47VvUTSMRiKQwDJaIQ"

	CONSUMER = OAuth::Consumer.new(
		CONSUMER_KEY, CONSUMER_SECRET, :site => "https://twitter.com")

	def self.access_token
		@@access_token = get_token("./access_token.yaml")
	end

	def self.request_access_token
		request_token = CONSUMER.get_request_token
		authorize_url = request_token.authorize_url
		puts "Go to this URL: #{authorize_url}"
		Launchy.open (authorize_url)

		puts "Login, and type your verification code in"
		oauth_verifier = gets.chomp

		access_token = request_token.get_access_token(
			:oauth_verifier => oauth_verifier)
	end

	def self.get_token(token_file)
		if File.exist?(token_file)
			File.open(token_file) { |f| YAML.load(f) }
		else
			@@access_token = request_access_token
			File.open(token_file, "w" ) { |f| YAML.dump(@@access_token, f) }

			@@access_token
		end

	end
end

class Status

	def initialize(author, message)
		@author = author
		@message = message
	end

	def text
		@message
	end

	def user
		@author
	end

	def post
		return unless user = EndUser.me
		endpoint = Addressable::URI.new(
			:scheme => "https",
			:host => "api.twitter.com",
			:path => "1.1/statuses/update.json").to_s
		posting = TwitterSession.access_token.post(endpoint, {status: text})
		posting.body
		twitter_posting = Status.parse(posting.body)
		puts "You have tweeted:"
		puts twitter_posting["text"]
	end


#return to this. what are we trying to show here?
	def self.parse(json)
		JSON.parse(json)
	end

end

class User
	attr_accessor :screen_name

	def self.parse(json)
	end

	def self.parse_many(json)
		user_array = []
		JSON.parse(json)["users"].each do |follower|
			user_array << User.new(follower["screen_name"])
			end
		user_array.map { |user| p user.screen_name }
	end

	def initialize(screen_name)
		@screen_name = screen_name
	end

	def timeline
		url = Addressable::URI.new(
			:scheme => "http",
			:host => "api.twitter.com",
			:path => "1.1/statuses/user_timeline.json",
			:query_values => {
				screen_name: @screen_name
				}).to_s
		result = TwitterSession.access_token.get(url).body
		JSON.parse(result).each do |tweet|
			puts tweet["text"]
		end
		nil
	end

	def followers
		url = Addressable::URI.new(
			:scheme => "http",
			:host => "api.twitter.com",
			:path => "1.1/followers/list.json",
			:query_values => {
				screen_name: @screen_name
				}).to_s
		result = TwitterSession.access_token.get(url).body
		User.parse_many(result)
	end

	def followed_users
		url = Addressable::URI.new(
			:scheme => "http",
			:host => "api.twitter.com",
			:path => "1.1/friends/list.json",
			:query_values => {
				screen_name: @screen_name
				}).to_s
		result = TwitterSession.access_token.get(url).body
		User.parse_many(result)
	end


end

class EndUser < User

	def self.set_user_name(user_name)
		@@current_user = EndUser.new(user_name)
	end

	def self.me
		@@current_user
	end

	def post_status(status_text)
		tweet = Status.new(self, status_text)
		tweet.post
	end

end