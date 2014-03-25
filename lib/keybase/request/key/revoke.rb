# POST /key/revoke.json
# revocation_type:   0
# kid:               "a140c70404a13370f7..."
module Keybase
  module Request
    class Key < Base
      def self.revoke(kid)
        post('key/revoke.json', revocation_type: 0,
             csrf_token: TokenStore.csrf, kid: kid)
        true
      end
    end
  end
end
