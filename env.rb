require "yaml"
require "bundler"
Bundler.require :default

STATE = {}

STATE[:config] = {}
require_relative "lib/config_utils"
include ConfigUtils

GPT3_STOP_TOKENS = [
  "# DESCRIPTION\n",
  "# IMPLEMENTATION\n",
]

GENERATORS = {
  app: {
    filepath: "app.rb",
  },
  models: {
    filepath: "models.rb"
  },
  environment: {
    filepath: "env.rb"
  },
  css: {
    filepath: "public/css/style.css",
  },
  layout: {
    filepath: "views/layout.haml",
  },
  index_page: {
    filepath: "views/index.haml",
  },
  secondary_page: {
    filepath: "views/page2.haml",
  },
  # controller_action_index: {
  #   filepath: "app.rb",
  # },
  # controller_action_page2: {
  #   filepath: "app.rb",
  # },
}

require_relative "lib/gpt_prompt"
require_relative "lib/generate_app"
require_relative "lib/monkeypatches"
include Monkeypatches
