# GET /user/lookup.json?username=USERNAME
module Keybase
  module Request
    class Root < Base
      def self.login(email_or_username, hmac_pwh, login_session)
        post('login.json', email_or_username: email_or_username,
                            hmac_pwh: hmac_pwh, login_session: login_session)
      end
    end
  end
end
