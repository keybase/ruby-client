module Keybase
  
  require_relative '../../../../test_helper'
  
  class UserTest < Minitest::Test
    def setup
      @user = User.new(EXAMPLE_USER)
    end
    
    def test_unix_times_parsed_to_dates_for_basics
      assert_equal "2013-10-30T19:24:21+00:00",
                    @user.basics.created_at.to_s
      assert_equal "2013-10-30T19:41:01+00:00",
                    @user.basics.updated_at.to_s
    end
    
    def test_unix_times_parsed_to_dates_for_profile
      assert_equal "2013-10-31T19:22:19+00:00",
                   @user.profile.updated_at.to_s      
    end

    def test_unix_times_parsed_to_dates_for_public_keys
      assert_equal "2013-11-05T21:00:12+00:00",
                   @user.public_keys.primary.created_at.to_s
      assert_equal "2013-11-05T21:00:12+00:00",
                   @user.public_keys.primary.updated_at.to_s
    end
        
    def test_unix_times_parsed_to_dates_for_private_keys
      assert_equal "2013-11-05T21:00:12+00:00",
                   @user.private_keys.primary.created_at.to_s
      assert_equal "2013-11-05T21:00:12+00:00",
                   @user.private_keys.primary.updated_at.to_s
    end
    
    def test_emails_set_correctly
      assert_equal EXAMPLE_USER['emails']['primary']['email'], @user.emails.primary.email 
      assert_equal true, @user.emails.primary.is_verified?
      assert_equal EXAMPLE_USER['emails']['secondary']['email'], @user.emails.secondary.email
      assert_equal false, @user.emails.secondary.is_verified?
    end

    def test_user_lookup_loads_from_returned_hash
      Request::User.stub :lookup, EXAMPLE_USER do
        user = User.lookup('foo')
        assert_equal EXAMPLE_USER['id'], user.id
      end
    end
    
    def test_object_loads_when_data_missing
      @empty = User.new({})
      assert_nil @empty.basics
      assert_nil @empty.profile
      assert_nil @empty.emails
      assert_nil @empty.public_keys
      assert_nil @empty.private_keys
    end
    
  end
end
