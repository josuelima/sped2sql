# -*- encoding: utf-8 -*-
if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'sped2sql'

RSpec.configure do |config|
  config.order = :random
end

module FiltroVazio
  def self.call(env)
    env
  end
end

module FiltroAdd
  def self.call(env)
    env[:total] = env[:total] + 100
    env
  end
end