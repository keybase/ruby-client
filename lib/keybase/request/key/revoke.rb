# POST /key/revoke.json
# revocation_type:   0
# kid:               "a140c70404a13370f7..."
# csrf_token:        "lgwefwefwHZIwfee99..."
module Keybase
  module Request
    class Key < Base
      def self.revoke(params)
        post('key/revoke.json', params)
      end
    end
  end
end
