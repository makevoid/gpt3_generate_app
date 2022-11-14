# write a roda boilerplate app
# ---
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
end
# ---
# write a roda app that fetches the weather in London
# ---
class Foo
  def bar(baz:)
    resp = Excon.get baz, { query: { weather_location: "London, UK" } }
    qux = resp.body
    puts qux
    qux
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

    r.on "quux" do
      r.get do
        foo = Foo.new
        qux = foo.bar baz: baz
        # ...
      end
    end

    r.public
  end
end
# ---
# write a roda app that fetches the temperature in Dubai
# ---
require "json"
require "bundler/setup"
Bundler.require :default

class Foo
  def bar
    url = WEATHER_API_URL
    Excon.get url, { query: { weather_location: "Dubai, UAE" } }
    baz = resp.body
    baz = JSON.parse baz
    puts baz
    baz
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

    r.on "quux" do
      r.get do
        foo = Foo.new
        bar = foo.bar
        # ...
      end
    end

    r.public
  end
end
# ---
# write a roda app that fetches the bitcoin price in USD
# ---
source "https://rubygems.org"

gem "roda"
gem "excon"
# -
require "json"
require "bundler/setup"
Bundler.require :default

class Foo
  def bar
    url = CRYPTO_TICKERS_API_URL
    Excon.get url, { query: { currency_pair: "BTCUSD" } }
    baz = resp.body
    baz = JSON.parse baz
    puts baz
    baz
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

    r.on "quux" do
      r.get do
        foo = Foo.new
        bar = foo.bar
        # ...
      end
    end

    r.public
  end
end

# write a model that stores hashes as json on redis
# ---
source "https://rubygems.org"

gem "redis"
# ---
require "json"
require "bundler/setup"
Bundler.require :default

R = Redis.new

class Foo

  def initialize
    # ...
  end

  def bar=(baz)
    puts "set bar: #{baz}"
    baz = baz.to_json
    ok = R.set "bar", baz
    puts ok
    ok
  end

  def bar
    puts "get bar:"
    baz = R.get "bar"
    puts baz
    baz
  end
end

foo = Foo.new
foo.bar = "{ \"qux\": \"quux\" }"
foo.bar #=> "{ \"qux\": \"quux\" }"
# ---
# write an app that fetches the weather and stores it in redis as json
# ---
source "https://rubygems.org"

gem "roda"
gem "excon"
gem "redis"
# -
require "json"
require "bundler/setup"
Bundler.require :default

R = Redis.new

class Foo
  def initialize
    # ...
  end

  def bar
    url = WEATHER_API_URL
    Excon.get url, { query: { weather_location: "London, UK" } }
    baz = resp.body
    baz = JSON.parse baz
    puts baz
    baz
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

    r.on "quux" do
      r.get do
        foo = Foo.new
        bar = foo.bar
        qux = Qux.new
        qux.corge grault: bar
        # ...
      end
    end

    r.public
  end
end
# ---
# write an app that gets the price of aapl and renders it in a view
# ---
class Foo
  def bar
    url = STOCK_PRICE_API_URL
    Excon.get url, { query: { ticker_symbol: "AAPL" } }
    baz = resp.body
    baz = JSON.parse baz
    puts baz
    baz
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

    r.on "quux" do
      r.get do
        foo = Foo.new
        bar = foo.bar
        haml :index, locals: { bar: bar }
      end
    end

    r.public
  end
end
# ---
# write an app that gets the weather in Cairo, stores it in Redis as JSON and renders it in a view
# ---
R = Redis.new

class Foo
  def initialize
    # ...
  end

  def bar
    url = WEATHER_API_URL
    Excon.get url, { query: { weather_location: "Cairo, Egypt" } }
    baz = resp.body
    baz = JSON.parse baz
    puts baz
    baz
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

    r.on "quux" do
      r.get do
        foo = Foo.new
        bar = foo.bar
        qux = Qux.new
        qux.corge grault: bar
        haml :index, locals: { bar: bar }
      end
    end

    r.public
  end
end
# ---
# write a roda app that <PROMPT>
