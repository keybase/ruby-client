require_relative '../test_helper'
require_relative '../integration_test_helper'

module Keybase
  class LoginUsersTest < Minitest::Test
    
    def test_login
      VCR.use_cassette('user_login_foo') do
        session, user = User.login('seanhandley', 'secret')
        assert_equal "secret", session
        assert_equal "secret", user.private_keys.primary.bundle
        assert_equal "dude@testing.com", user.emails.primary.email
      end
    end

  end
end
