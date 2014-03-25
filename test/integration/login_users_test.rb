require_relative '../test_helper'
require_relative '../integration_test_helper'

module Keybase
  class LoginUsersIntegrationTest < Minitest::Test
    
    def test_login
      VCR.use_cassette('user_login_foo') do
        user = User.login('seanhandley', 'secret')
        assert_equal "secret", user.private_keys.primary.bundle
        assert_equal "dude@testing.com", user.emails.primary.email
        assert_equal 'lgHZIGI3OTQ0MzYxZDI0NzdmMmM4YTlkNzJjOWVkZWNlNzA4zlMvTE/OAAFRgMDEIJ6M5LAAPzkqRi9BLRImwFV0v9Nh0tcL1Whuf1y5ZyE+', TokenStore.csrf
        assert_equal 'guest=lgHZIDk4OTFhMWY4NTg3ZmM4NWQxMmUzOTlkMzJlZDk4NDA4zlMvTFDOAAFRgMDEIIR3zxU0IOIdPEJDrCDC9jLHqPxB%2Bg8qGhx1NdtAg4kH; Max-Age=604.8; Domain=.keybase.io; Path=/; Expires=Sun, 23 Mar 2014 21:14:21 GMT; HttpOnly; Secure, session=lgHZIGU3MjBmNWE0Y2NlOWM2MGY5NDUzOGQzMDk1OWU3MTAwzlMvTFDOAeEzgNkgYTZjZmJmYjg0MWIzOGRlODk4MzZlYzY3ODZiMWFjMDLEIGOPTA3Memn2DZjT9OnMkCEQ9d7bEF5R29HbDrXwRz11; Max-Age=31536000; Domain=.keybase.io; Path=/; Expires=Mon, 23 Mar 2015 21:04:16 GMT; HttpOnly; Secure', TokenStore.cookie
      end
    end

  end
end
