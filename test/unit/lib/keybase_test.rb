module Keybase
  
  require_relative '../test_helper'
  
  class KeybaseTest < Minitest::Test
    def test_keybase_calls_user_lookup
      User.stub :lookup, true do
        assert_equal true, Keybase.lookup('foo')
      end
    end
    
    def test_keybase_calls_dump_all
      Dump.stub :all, true do
        assert_equal true, Keybase.dump_all
      end
    end
    
    def test_keybase_calls_dump_latest
      Dump.stub :latest, true do
        assert_equal true, Keybase.dump_latest
      end
    end
    
  end
end
