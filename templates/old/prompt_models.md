# DESCRIPTION
# a class WeatherForecast with a method `forecast` that takes a location argument
# the `forecast` method fetches the weather from the a weather api using excon get
# IMPLEMENTATION

# ## WeatherForecast class:
#
# a class that fetches the weather forecast
#
# ### Methods:
#
#    `forecast`: gets the weather from the weather api
#
# ### Usage:
#
#     API_KEY="..." LOCATION="London, UK" ruby weather_forecast.rb

DEBUG = true

class WeatherForecast
  def self.forecast(location:)
    new(location: location).forecast
  end

  attr_reader :api_key, :location

  def initialize(location:)
    @api_key = ENV["API_KEY"]
    raise "ApiKeyNotProvidedError" unless api_key
  end

  def forecast
    city_name = location
    resp = Excon.get "https://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{api_key}"
    resp = JSON.parse resp
    if DEBUG
      puts "forecast: #{location.inspect}"
      puts resp.to_yaml
    end
    resp
  end
end

if $0 == __FILE__
  require "bundler"
  Bundler.require :default
  require "json"
  require "yaml"
  location = ENV["LOCATION"]
  raise "LocationNotProvidedError" unless location
  api_key = ENV["API_KEY"]
  raise "ApiKeyNotProvidedError" unless api_key
  WeatherForecast.forecast location: location
end

# gems:
# - gem "excon"
# DESCRIPTION
# a class BlockchainAPIPrice with a method `btc`
# the `btc` method gets the current bitcoin price in USD
# IMPLEMENTATION

# ## BlockchainAPIPrice class:
#
# a class that fetches the current price of bitcoin
#
# ### Methods:
#
#    `btc`: gets the price of bitcoin in USD
#
# ### Usage:
#
#     ruby blockchain_api_price.rb

DEBUG = true

class BlockchainAPIPrice
  def self.btc
    new.btc
  end

  def initialize
  end

  def btc
    ticker_symbol = "BTC-USD"
    resp = Excon.get "https://api.blockchain.com/v3/exchange/tickers/#{ticker_symbol}"
    resp = JSON.parse resp
    if DEBUG
      puts "api response:"
      puts resp.to_yaml
    end
    resp = resp.fetch "last_trade_price"
    resp
  end
end

if $0 == __FILE__
  require "bundler"
  Bundler.require :default
  require "json"
  require "yaml"
  BlockchainAPIPrice.btc
end

# gems:
# - gem "excon"
# DESCRIPTION
# a class BlockchainAPIBlock with a method `last_block_hash`
# the `last_block_hash` method gets the latest known blockchain block hash
# the class has also a method `last_block_hash`
# the `last_block` method fetches the last block from the blockchain returning the full block info
# IMPLEMENTATION

# ## BlockchainAPIBlock class:
#
# a class that fetches the weather last_block
#
# ### Methods:
#
#    `last_block_hash`: gets the latest block hash
#    `last_block`: gets the full info of the latest blockchain block
#
# ### Usage:
#
#     ruby blockchain_api_block.rb

DEBUG = true

class BlockchainAPIBlock
  def self.last_block_hash
    new.last_block_hash
  end

  def self.last_hash
    new.last_hash
  end

  attr_reader :api_key, :location

  def initialize(location:)
    @api_key = ENV["API_KEY"]
    raise "ApiKeyNotProvidedError" unless api_key
  end

  def last_block_hash
    block_hash = Excon.get "https://blockchain.info/q/latesthash"
    block_hash = JSON.parse block_hash
    if DEBUG
      puts "last block hash:"
      puts block_hash.to_yaml
    end
    block_hash
  end

  def last_block
    block_id = last_block_hash
    block_data = Excon.get "https://blockchain.info/rawblock/#{block_id}"
    block_data = JSON.parse block_data
    if DEBUG
      puts "last block: (block_id: #{block_id})"
      puts block_data.to_yaml
    end
    block_data
  end
end

if $0 == __FILE__
  require "bundler"
  Bundler.require :default
  require "json"
  require "yaml"
  last_block_hash = BlockchainAPIBlock.last_block_hash
  puts "last block hash: #{last_block_hash}"
  BlockchainAPIBlock.last_block
end

# gems:
# - gem "excon"
# DESCRIPTION
# a class <PROMPT>
