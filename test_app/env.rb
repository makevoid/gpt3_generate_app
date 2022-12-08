require "bundler"
Bundler.require :default, :development

# TWITTER_API_TOKEN = File.read(File.expand_path "~/.twitter_api_token")
# TWITTER_API_URL = "https://api.twitter.com/1.1/users/show.json?screen_name=makevoid"

DATABASE_URL = "./db.sqlite"
ENV["DATABASE_URL"] = DATABASE_URL

DB = Sequel.connect "sqlite://#{DATABASE_URL}"

module ModelUtils
  def require_all_models
    models = Dir.glob "../generated_apps/01/model_*.rb"
    models.reject! { |model| model.include? "model_method" }
    raise "ModelNotFoundError" if models.empty?
    models.each do |model|
      require_relative model
    end
  end
end

include ModelUtils

require_all_models

puts "env loaded"