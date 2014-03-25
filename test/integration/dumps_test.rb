require_relative '../test_helper'
require_relative '../integration_test_helper'

module Keybase
  class DumpsIntegrationTest < Minitest::Test
    
    def setup
      VCR.use_cassette('dumps') do
        @all = Keybase.dump_all
        @latest = Keybase.dump_latest
      end
    end
    
    def test_latest_dump_object_has_expected_fields
      assert @latest.respond_to? :id
    end
    
    def test_first_dump_object_has_expected_fields
      assert @all[0].respond_to? :id
    end
    
  end
end