require "yaml"

# TODO: load from a yml config file
APP_IDX = "01"
# YAML.load_file "./test_config.yml" # load app id from yaml config


require_relative "env"
require_relative "../generated_apps/#{APP_IDX}/app"

run App
