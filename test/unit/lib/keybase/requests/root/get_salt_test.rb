require_relative '../../../../../test_helper'

module Keybase
  module Request
    class RootGetSaltTest < Minitest::Test

      def setup
        @response = { 'salt' => 'salt', 'csrf_token' => 'csrf', 
                      'login_session' => 'session'
                    }
      end

      def test_get_salt_returns_salt_and_login_session
        Base.stub :get, @response do
          salt, session = Request::Root.get_salt_and_login_session('foo')
          assert_equal "salt", salt
          assert_equal "session", session
        end
      end
      
    end
  end
end