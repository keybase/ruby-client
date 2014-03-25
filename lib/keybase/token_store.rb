module Keybase
  # @private
  class TokenStore
    
    attr_accessor :csrf, :cookie
    
    def self.csrf
      instance.csrf
    end
  
    def self.csrf=(csrf)
      instance.csrf = csrf
    end
    
    def self.cookie
      instance.cookie
    end
  
    def self.cookie=(cookie)
      instance.cookie = cookie
    end
    
    def self.instance
      @@instance ||= new
    end
  
    private
  
    def initialize ; end
  
  end
end