require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'sped2sql'

RSpec.configure do |config|
  config.order = :random
end
