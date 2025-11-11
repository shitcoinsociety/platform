Mailgun.configure do |config|
  config.api_key = ENV["MAILGUN_API_KEY"]
  config.domain  = "shitcoinswap.com"
  config.api_host = "api.eu.mailgun.net"
end
