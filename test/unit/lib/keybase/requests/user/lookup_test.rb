require_relative '../../../../../test_helper'

module Keybase
  module Request
    class LookupTest < Minitest::Test
      def setup
        @response = { 'them' => true }
      end

      def test_lookup_returns_them
        Base.stub :get, @response do
          assert_equal true, User.lookup('foo') # returns true
        end
      end
    end
  end
end
