# GET /user/lookup.json?username=USERNAME
module Keybase
  module Request
    class User < Base
      def self.lookup(username)
        get('user/lookup.json', username: username)['them']
      end
    end
  end
end
