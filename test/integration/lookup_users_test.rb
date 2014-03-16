require_relative '../integration_test_helper'

module Keybase
  class LookupUsersTest < Test::Unit::TestCase
    
    def setup
      VCR.use_cassette('user_lookup_foo') do
        @user = User.lookup("foo")
      end
    end
    
    def test_request_returns_user_hash
      assert @user.respond_to? :id
    end
    
    def test_user_not_found
      VCR.use_cassette('user_lookup_not_found') do
        assert_raise_with_message(Keybase::UserNotFoundError, 'user not found foofoofooofo') do
          @user = User.lookup('foofoofooofo')  
        end
      end      
    end
    
  end
end