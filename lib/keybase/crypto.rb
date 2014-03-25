module Keybase
  class Crypto
    SCRYPT_VARS = {'N' => 2**15, 'r' => 8, 'p' => 1, 'key_length' => 224, 'chunk' => 192..-1}
    def self.scrypt(passphrase, salt)
      SCrypt::Engine.scrypt(passphrase, hex2bin(salt),
                                   SCRYPT_VARS['N'], SCRYPT_VARS['r'],
                                   SCRYPT_VARS['p'], SCRYPT_VARS['key_length']
                                 )[SCRYPT_VARS['chunk']]
    end
    
    def self.hmac_sha512(key, data)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA512.new, key, Base64.decode64(data))
    end
    
    def self.hex2bin(hex)
      [hex].pack("H*")
    end
  end
end