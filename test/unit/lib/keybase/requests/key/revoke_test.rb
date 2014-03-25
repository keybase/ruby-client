require_relative '../../../../../test_helper'

module Keybase
  module Request
    class KeyRevokeTest < Minitest::Test

      def setup
        @response = {  }
      end

      def test_key_revoke_returns_true
        Base.stub :post, @response do
          assert Request::Key.revoke('foo')
        end
      end
      
    end
  end
end
