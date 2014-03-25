if require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
  end
end

require_relative '../lib/keybase'
EXAMPLE_USER_JSON = IO.read(File.expand_path('../fixtures/example_user.json', __FILE__))
EXAMPLE_USER      = JSON.parse(EXAMPLE_USER_JSON)
EXAMPLE_DUMP_JSON = IO.read(File.expand_path('../fixtures/example_dump.json', __FILE__))
EXAMPLE_DUMP      = JSON.parse(EXAMPLE_DUMP_JSON)

TEST_ENV = true

require 'rubygems'
gem "minitest"
require 'minitest/autorun'
