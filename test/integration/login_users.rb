require_relative '../test_helper'
require_relative '../integration_test_helper'

module Keybase
  class LoginUsersTest < Minitest::Test
    
    def setup
    end
    
    def test_login
      VCR.use_cassette('user_login_foo') do
        begin
          system "stty -echo"
          print "Passphrase: "
          @passphrase = gets.chomp
          puts
        ensure
          system "stty echo"
        end
        User.login('seanhandley', @passphrase)
      end
    end

  end
end
