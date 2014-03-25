require_relative '../test_helper'
require_relative '../integration_test_helper'

module Keybase
  class LookupUsersIntegrationTest < Minitest::Test
    
    def setup
      VCR.use_cassette('user_lookup_foo') do
        @user = Keybase.lookup("foo")
      end
    end
    
    def test_user_object_has_expected_fields
      assert @user.respond_to? :id
    end
    
    def test_user_not_found
      VCR.use_cassette('user_lookup_not_found') do
        assert_raises(Keybase::UserNotFoundError, 'user not found foofoofooofo') do
          @user = User.lookup('foofoofooofo')  
        end
      end      
    end
    
    def test_username_missing
      VCR.use_cassette('user_lookup_missing') do
        assert_raises(Keybase::InputError, 'missing or invalid input. username: missing name') do
          @user = User.lookup('')  
        end
      end      
    end
    
    def test_username_invalid
      VCR.use_cassette('user_lookup_invalid') do
        assert_raises(Keybase::InputError, 'missing or invalid input. username: invalid name') do
          @user = User.lookup('d8dw9sfu83u39229i9fewdsi0-fdsii-i')  
        end
      end      
    end
    
  end
end