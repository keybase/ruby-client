# POST sig/post_auth.json
# sig :               "----- BEGIN PGP MESSAGE ----- ..."
# email_or_username : "maxtaco"
module Keybase
  module Request
    class Sig < Base
      def self.post_auth(email_or_username, sig)
        post('sig/post_auth.json', email_or_username: email_or_username,
                                   sig: sig)['auth_token']
      end
    end
  end
end
