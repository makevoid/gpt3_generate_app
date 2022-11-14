require "yaml"
require "bundler"
Bundler.require :default

require_relative "lib/gpt_prompt"
require_relative "lib/generate_app"
require_relative "lib/monkeypatches"
include Monkeypatches
