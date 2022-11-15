require "bundler"
Bundler.require :default, :development

puts "env loaded"

# TWITTER_API_TOKEN = File.read(File.expand_path "~/.twitter_api_token")
# TWITTER_API_URL = "https://api.twitter.com/1.1/users/show.json?screen_name=makevoid"

DATABASE_URL = "./db.sqlite"
ENV["DATABASE_URL"] = DATABASE_URL
