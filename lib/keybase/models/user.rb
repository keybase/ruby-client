module Keybase
  class User
    
    attr_reader :id

    def initialize(params)
      @id = params['id']
    end
    
    def self.lookup(username)
      new(Request::User.lookup(username))
    end
  end
end
