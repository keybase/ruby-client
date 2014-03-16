require_relative '../lib/keybase'

require 'bundler/setup'
require 'test/unit'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :webmock
end