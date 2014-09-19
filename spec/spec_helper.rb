# -*- encoding: utf-8 -*-
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

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