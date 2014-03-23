# GET /user/lookup.json?username=USERNAME
module Keybase
  module Request
    class Root < Base
      def self.get_salt_and_login_session(email_or_username)
        result = get('getsalt.json', email_or_username: email_or_username)
        return [result['salt'], result['login_session']]
      end
    end
  end
end
