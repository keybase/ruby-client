# POST /key/add.json
# public_key:     "-----BEGIN PGP PUBLIC..."
# private_key:    "hKRib2R5gqRwcml2gqRkY..."
# is_primary:     true
module Keybase
  module Request
    class Key < Base
      def self.add(public_key=nil, private_key=nil)
        params = {is_primary: true}
        params.merge(public_key: public_key) if public_key
        params.merge(private_key: private_key) if private_key
        post('key/add.json', params)
      end
    end
  end
end
