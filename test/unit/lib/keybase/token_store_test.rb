module Keybase
  require_relative '../../../test_helper'
  
  class TokenStoreTest < Minitest::Test
    def setup
      TokenStore.cookie = nil
      TokenStore.csrf = nil
    end
    
    def test_token_store_sets_cookie
      TokenStore.cookie = 'foo'
      assert_equal 'foo', TokenStore.cookie
      TokenStore.cookie = 'bar'
      assert_equal 'bar', TokenStore.cookie
    end
    
    def test_token_store_sets_csrf
      TokenStore.csrf = 'foo'
      assert_equal 'foo', TokenStore.csrf
      TokenStore.csrf = 'bar'
      assert_equal 'bar', TokenStore.csrf
    end
    
  end
end
