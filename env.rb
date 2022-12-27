require "yaml"
require "bundler"
Bundler.require :default, :development

STATE = {}

STATE[:config] = {}
STATE[:models] = {} 
STATE[:model_methods] = {} 
# NOTE: we need to keep track of model methods so that we can write the right model method for the right model

require_relative "lib/config_utils"
include ConfigUtils

GPT3_STOP_TOKENS = [
  "# DESCRIPTION\n",
  "# IMPLEMENTATION\n",
]

TEMPLATE_PATHS = {
  prompt_app: "app.md",
  prompt_route: "route_%s.rb",
  prompt_model: "model_%s.rb",
  prompt_model_method: "model_method_%s.rb",
  prompt_environment: "env.rb",
  prompt_css: "public/css/style.css",
  prompt_layout:         "views/layout.haml",
  prompt_index_page:     "views/index.haml",
  prompt_secondary_page: "views/page2.haml",

  # controller_action_index: {
  #   filepath: "app.rb",
  # },
  # controller_action_page2: {
  #   filepath: "app.rb",
  # },
}

# load libraries
require_relative "lib/gpt_prompt"
require_relative "lib/app_testing"
require_relative "lib/generate_app"
require_relative "lib/monkeypatches"
include Monkeypatches

OPENAI_API_KEY = File.read(File.expand_path "~/.openai_api_key").strip
GPT3 = OpenAI::Client.new access_token: OPENAI_API_KEY
