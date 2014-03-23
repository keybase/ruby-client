module Keybase
  
  require_relative '../../../../test_helper'
  
  class UserTest < Minitest::Test
    def setup
      @user_hash = {'id' => 1}
    end

    def test_user_lookup_loads_from_returned_hash
      Request::User.stub :lookup, @user_hash do
        user = User.lookup('foo')
        assert_equal @user_hash['id'], user.id
      end
    end
    
  end
end
