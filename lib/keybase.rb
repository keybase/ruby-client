require 'faraday'
require 'json'
require 'date'
require 'scrypt'
require 'openssl'
require 'base64'
require 'securerandom'

module Keybase 
  require_relative 'keybase/crypto'
  require_relative 'keybase/error'
  require_relative 'keybase/models/user'
  require_relative 'keybase/models/dump'
  require_relative 'keybase/request/base'
  require_relative 'keybase/request/dump/all'
  require_relative 'keybase/request/dump/latest'
  require_relative 'keybase/request/key/add'
  require_relative 'keybase/request/key/revoke'
  require_relative 'keybase/request/root/get_salt_and_login_session'
  require_relative 'keybase/request/root/login'
  require_relative 'keybase/request/sig/post_auth'
  require_relative 'keybase/request/user/lookup'
  require_relative 'keybase/response'
  require_relative 'keybase/token_store'
  
  # Lookup a user on Keybase
  #
  # @param [String] username the username of the user you are searching for
  # @raise [Keybase::UserNotFoundError] if the user is not found
  # @raise [Keybase::InputError] if the username is empty or invalid
  # @return [Keybase::Model::User] the user, if they exist
  def self.lookup(username)
    User.lookup(username)
  end

  # Retrieve the dump history from Keybase
  #
  # @return [[Keybase::Dump]] a collection of all Keybase dumps
  def self.dump_all
    Dump.all
  end

  # Retrieve the latest dump from Keybase
  #
  # @return [Keybase::Dump] latest Keybase dump
  def self.dump_latest
    Dump.latest
  end
end
