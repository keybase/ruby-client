# POST /key/add.json
# public_key:     "-----BEGIN PGP PUBLIC..."
# private_key:    "hKRib2R5gqRwcml2gqRkY..."
# is_primary:     true
module Keybase
  module Request
    class Key < Base
      def self.add(params)
        post('key/add.json', params.merge(is_primary: true))['kid']
      end
    end
  end
end
