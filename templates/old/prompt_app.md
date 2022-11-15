# DESCRIPTION
# write a roda boilerplate app
# IMPLEMENTATION
class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger

  route do |r|
    r.root do
      # ...
    end

    r.on "foo" do
      r.get do
        # ...
      end
    end

    r.public
  end

  error do |e|
    { error: { name: e.class.name, stacktrace: e.backtrace }}
  end
end
# DESCRIPTION
# write a roda app that fetches the weather in London
# IMPLEMENTATION
class Weather
  def get(lat:, lng:)
    url = "https://api.open-meteo.com/v1/forecast"
    resp = Excon.get url, { query: { latitude: lat, longitude: lng, hourly: "temperature_2m", rain: 1 } }
    resp = resp.body
    resp = JSON.parse resp
    puts resp
    resp
  end
end

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger

  route do |r|
    r.root do
      # ...
    end

    r.on "weather" do
      r.get do
        weather = Weather.new
        result = weather.get lat: "28.03", lng: "-16.56"
        { weather: result }
      end
    end

    r.public
  end

  error do |e|
    { error: { name: e.class.name, stacktrace: e.backtrace }}
  end
end
# DESCRIPTION
# write a roda app that fetches the bitcoin 7d avg price in USD
# IMPLEMENTATION
require "json"
require "bundler/setup"
Bundler.require :default

class BitcoinPrice
  def get
    url = "http://api.bitcoincharts.com/v1/weighted_prices.json"
    Excon.get url
    resp = resp.body
    resp = JSON.parse resp
    resp = resp.fetch "USD"
    resp = resp.fetch "7d"
    resp = resp.to_f
    puts resp
    resp
  end
end

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger

  route do |r|
    r.root do
      # ...
    end

    r.on "price" do
      r.get do
        price = BitcoinPrice.new
        price = price.get
        { price: price }
      end
    end

    r.public
  end

  error do |e|
    { error: { name: e.class.name, stacktrace: e.backtrace }}
  end
end
# DESCRIPTION
# write an app that fetches the weather and stores it in redis as json
# IMPLEMENTATION
require "json"
require "bundler/setup"
Bundler.require :default

R = Redis.new

class Weather
  def get(lat:, lng:)
    url = "https://api.open-meteo.com/v1/forecast"
    resp = Excon.get url, { query: { latitude: lat, longitude: lng, hourly: "temperature_2m", rain: 1 } }
    resp = resp.body
    resp = JSON.parse resp
    puts resp
    resp
  end
end

class Qux
  def initialize
    # ...
  end

  def corge(grault:)
    puts "set corge: #{grault}"
    grault = grault.to_json
    ok = R.set "corge", grault
    puts ok
    ok
  end

  def corge
    puts "get corge:"
    corge = R.get "corge"
    puts corge
    corge
  end
end

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger

  route do |r|
    r.root do
      # ...
    end

    r.on "weather" do
      r.get do
        weather = Weather.new
        result = weather.get lat: "28.03", lng: "-16.56"
        bar = foo.bar
        qux = Qux.new
        qux.corge grault: result
        { weather: result }
      end
    end

    r.public

    error do |e|
      { error: { name: e.class.name, stacktrace: e.backtrace }}
    end
  end
end
# DESCRIPTION
# write an app that gets the price of aapl and renders it in a view
# IMPLEMENTATION
class Stock
  def price(symbol:)
    url = https://www.alphavantage.co/query
    Excon.get url, { query: { function: "TIME_SERIES_WEEKLY", symbol: symbol, apikey: "demo } }
    resp = resp.body
    resp = JSON.parse resp
    puts resp
    resp
  end
end

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger

  route do |r|
    r.root do
      # ...
    end

    r.on "price" do
      r.get do
        stock = Stock.new
        price = stock.price symbol: "AAPL"
        { price: price }
      end
    end

    r.public
  end

  error do |e|
    { error: { name: e.class.name, stacktrace: e.backtrace }}
  end
end
# DESCRIPTION
# write a roda app that <PROMPT>
