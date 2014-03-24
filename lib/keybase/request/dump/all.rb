# GET dump/all.json
module Keybase
  module Request
    class Dump < Base
      def self.all
        get('dump/all.json', {})['dumps']
      end
    end
  end
end
