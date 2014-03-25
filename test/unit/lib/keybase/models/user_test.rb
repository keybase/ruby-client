module Keybase
  
  require_relative '../../../../test_helper'
  
  class UserTest < Minitest::Test
    def setup
      @user = User.new(EXAMPLE_USER)
      @username = 'foo'
      @salt = 'salt'
      @login_session = 'login_session'
      @passphrase = 'passphrase'
      @pwh = "secret"
      @kid = 123
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
    
    def test_login_calls_correct_methods
      get_salt_args = lambda {|email_or_username|
        assert_equal @username, email_or_username
        [@salt, @login_session]
      }
      login_args = lambda {|email_or_username, hmac_pwh, login_session|
        {'me' => EXAMPLE_USER}
      }
      scrypt_args = lambda {|passphrase, salt|
        assert_equal @passphrase, passphrase
        assert_equal @salt, salt
        @pwh
      }
      hmac_sha512_args = lambda{|key, data|
        assert_equal @login_session, data
        assert_equal @pwh, key
      }
      Request::Root.stub(:get_salt_and_login_session, get_salt_args) do
        Request::Root.stub(:login, login_args) do
          Crypto.stub(:scrypt, scrypt_args) do
            Crypto.stub(:hmac_sha512, hmac_sha512_args) do
              me = User.login(@username, @passphrase)
              assert_equal me.id, EXAMPLE_USER['id']
            end
          end
        end
      end
    end
    
    def test_post_auth_calls_correct_methods
      args = lambda {|username, sig|
        assert_equal @user.basics.username, username
        assert_equal 'foo', sig
        'auth_token'
      }
      Request::Sig.stub(:post_auth, args) do
        assert_equal 'auth_token', @user.post_auth('foo')
      end
    end
    
    def test_add_public_key_calls_correct_methods
      args = lambda {|params|
        assert_equal 'foo', params[:public_key]
        @kid
      }
      Request::Key.stub(:add, args) do
        assert_equal @kid, @user.add_public_key('foo')
      end
    end
    
    def test_add_private_key_calls_correct_methods
      args = lambda {|params|
        assert_equal 'foo', params[:private_key]
        @kid
      }
      Request::Key.stub(:add, args) do
        assert_equal @kid, @user.add_private_key('foo')
      end
    end
    
    def test_revoke_key_calls_correct_methods
      args = lambda {|kid|
        assert_equal @kid, kid
        true
      }
      Request::Key.stub(:revoke, args) do
        assert @user.revoke_key(@kid)
      end
    end
    
  end
end
