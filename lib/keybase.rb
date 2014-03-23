require 'faraday'
require 'json'
require 'date'
require 'scrypt'
require 'openssl'
require 'base64'

module Keybase 
  require_relative 'keybase/error'
  require_relative 'keybase/models/user'
  require_relative 'keybase/request/base'
  require_relative 'keybase/request/root/get_salt'
  require_relative 'keybase/request/root/login'
  require_relative 'keybase/request/user/lookup'
  require_relative 'keybase/response'
  
  def self.lookup(username)
    User.lookup(username)
  end
end
