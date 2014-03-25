SimpleCov.start if require 'simplecov'

require_relative '../lib/keybase'
EXAMPLE_USER = JSON.parse(IO.read(File.expand_path('../fixtures/example_user.json', __FILE__)))
EXAMPLE_DUMP = JSON.parse(IO.read(File.expand_path('../fixtures/example_dump.json', __FILE__)))

TEST_ENV = true

require 'rubygems'
gem "minitest"
require 'minitest/autorun'
