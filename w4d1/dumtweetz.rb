require 'launchy'
require 'oauth'
require 'yaml'

CONSUMER_KEY = "consumer_key_from_service"
CONSUMER_SECRET = "consumer_secret_from_service"

CONSUMER = OAuth::Consumer.new(
	CONSUMER_KEY, CONSUMER_SECRET, :site => "https://twitter.com")

def request_access_token

	request_token = CONSUMER.get_request_token
	authorize_url = request_token.authorize_url
	puts "Go to this URL: #{authorize_url}"
	Launchy.open(authorize_url)

	puts "Login, and type your verification code in"
	oauth_verifier = gets.chomp

	access_token = request_token.get_access_token(
		:oauth_verifier => oauth_verifier)

end

def user_timeline(access_token)

	access_token.get("http://api.twitter.com/1.1/statuses/user_timeline.json").body

end

def get_token(token_file)

	if File.exist?(token_file)
		File.open(token_file) { |f| YAML.load(f) }
	else
		access_token = request_access_token
		File.open(token_file, "w") { |f| YAML.dump(access_token, f) }

		access_token
	end
end