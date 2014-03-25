require_relative '../../../../../test_helper'

module Keybase
  module Request
    class KeyAddTest < Minitest::Test

      def setup
        @response = { 'kid' => 123 }
      end

      def test_key_add_returns_kid
        Base.stub :post, @response do
          assert_equal 123, Request::Key.add(public_key: 'foo')
        end
      end
      
    end
  end
end
