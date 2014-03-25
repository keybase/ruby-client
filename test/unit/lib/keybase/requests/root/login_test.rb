require_relative '../../../../../test_helper'

module Keybase
  module Request
    class RootLoginTest < Minitest::Test

      def setup
        @response = { }
      end

      def test_login_returns_response
        Base.stub :post, @response do
          assert_equal @response, Request::Root.login('foo', 'bar', 'baz')
        end
      end
      
    end
  end
end