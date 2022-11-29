require_relative "../env"
require_relative "lib/gpt3_mock"

Object.send :remove_const, :GPT3

GPT3 = GPT3Mock.new
