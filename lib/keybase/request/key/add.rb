# POST /key/add.json
# public_key:     "-----BEGIN PGP PUBLIC..."
# private_key:    "hKRib2R5gqRwcml2gqRkY..."
# csrf_token:     "lgHZIDU1YzA3OWJfff..."
# is_primary:     true
module Keybase
  module Request
    class Key < Base
      def self.add(params)
        post('key/add.json', params)
      end
    end
  end
end
