module Keybase
  
  require_relative '../test_helper'
  
  class KeybaseTest < Minitest::Test
    def test_keybase_calls_user_lookup
      User.stub :lookup, true do
        assert_equal true, Keybase.lookup('foo')
      end
    end
    
  end
end
