require_relative '../test_helper'
require_relative '../integration_test_helper'

module Keybase
  class KeysIntegrationTest < Minitest::Test
    
    def setup
      VCR.use_cassette('keys') do
        @me = User.login('seanhandley', 'secret')
        @public_key = @me.public_keys.primary.bundle
        @private_key = @me.private_keys.primary.bundle
        @old_public_kid = @me.public_keys.primary.kid
        @old_private_kid = @me.private_keys.primary.kid
        
        @me.revoke_key(@me.public_keys.primary.kid)
        @public_kid = @me.add_public_key(@public_key)
        @private_kid = @me.add_private_key(@private_key)
      end
    end
    
    def test_kids_match
      assert_equal @old_public_kid, @old_private_kid 
      assert_equal @public_kid, @private_kid
    end
  end
end