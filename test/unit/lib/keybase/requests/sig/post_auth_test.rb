require_relative '../../../../../test_helper'

module Keybase
  module Request
    class SigPostAuthTest < Minitest::Test

      def setup
        @response = { 'auth_token' => 'baz' }
      end

      def test_sig_post_auth_returns_auth_token
        Base.stub :post, @response do
          assert_equal 'baz', Request::Sig.post_auth('foo', 'bar')
        end
      end
      
    end
  end
end
