module Keybase
  require_relative '../../../test_helper'
  
  class CryptoTest < Minitest::Test
    def setup
      @passphrase = "passphrase"
      @salt = "salt"
      @key = "key"
      @data = "data"
      @random = SecureRandom.random_bytes(224).bytes
    end
    
    def test_scrypt_passes_to_engine_and_truncates_result
      args = lambda { |*args|
        assert_equal @passphrase, args[0]
        assert_equal [@salt].pack("H*"), args[1]
        @random
      }
      SCrypt::Engine.stub(:scrypt, args) do
        response = Crypto.scrypt(@passphrase, @salt)
        assert_equal 32, response.size
      end
    end
    
    def test_hmac_sha512_passes_to_openssl
      args = lambda { |_, key, data|
        assert_equal @key, key
        assert_equal Base64.decode64(@data), data
        nil
      }
      OpenSSL::HMAC.stub(:hexdigest, args) do
        Crypto.hmac_sha512(@key, @data)
      end      
    end
    
    def test_defines_scrypt_vars
      assert defined?(Crypto::SCRYPT_VARS)
    end
    
    def self.hmac_sha512(key, data)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA512.new, key, data)      
    end
    
  end
end