require 'faraday'
require 'json'
require 'date'
require 'scrypt'
require 'openssl'
require 'base64'
require 'faraday-cookie_jar'

module Keybase 
  require_relative 'keybase/token_store'
  require_relative 'keybase/error'
  require_relative 'keybase/models/user'
  require_relative 'keybase/request/base'
  require_relative 'keybase/request/dump/all'
  require_relative 'keybase/request/dump/latest'
  require_relative 'keybase/request/key/add'
  require_relative 'keybase/request/key/revoke'
  require_relative 'keybase/request/root/get_salt'
  require_relative 'keybase/request/root/login'
  require_relative 'keybase/request/sig/post_auth'
  require_relative 'keybase/request/user/lookup'
  require_relative 'keybase/response'
  
  def self.lookup(username)
    User.lookup(username)
  end
end
