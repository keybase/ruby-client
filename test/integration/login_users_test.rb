require_relative '../test_helper'
require_relative '../integration_test_helper'

module Keybase
  class LoginUsersIntegrationTest < Minitest::Test
    
    def test_login
      VCR.use_cassette('user_login') do
        user = User.login('seanhandley', 'secret')
        assert_equal "secret", user.private_keys.primary.bundle
        assert_equal "dude@testing.com", user.emails.primary.email
        assert_equal 'lgHZIDA0MmNjYWYwMTMxZmZlZDNiZGE1MDAyM2M3ZGEzNzA4zlMxfzfOAAFRgMDEIPBYxx9HWUnY8GVK2rYzx29hOQW5DXDNkONntT1FjGxI', TokenStore.csrf
        assert_equal 'guest=lgHZIGJkM2E1MGNmMjBjNmQ0MzQwMmFhMDI4Mjc4YzJiZjA4zlMxfzjOAAFRgMDEINQblgb3pKa15JV58bI2VqKfWGvPFe3qcLUuq153%2Be7C; Max-Age=604.8; Domain=.keybase.io; Path=/; Expires=Tue, 25 Mar 2014 13:16:04 GMT; HttpOnly; Secure, session=lgHZIGU3MjBmNWE0Y2NlOWM2MGY5NDUzOGQzMDk1OWU3MTAwzlMxfzjOAeEzgNkgODViZmU1ZGI4MzM3NzM4NDk2MDRmZGIzOWZkM2UxMDLEII%2B6%2FmdEgDo74uwb%2BQDMrDt6m06NFhs0eQjX9popcagO; Max-Age=31536000; Domain=.keybase.io; Path=/; Expires=Wed, 25 Mar 2015 13:06:00 GMT; HttpOnly; Secure', TokenStore.cookie
      end
    end

  end
end
