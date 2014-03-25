require_relative '../../../../../test_helper'

module Keybase
  module Request
    class UserLookupTest < Minitest::Test
      def setup
        @response = { 'them' => EXAMPLE_USER }
      end

      def test_lookup_returns_them
        Base.stub :get, @response do
          assert_equal 'bf5f1650fc1361a', Request::User.lookup('foo')['id']
        end
      end
    end
  end
end
