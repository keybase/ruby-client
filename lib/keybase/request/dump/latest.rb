# GET dump/latest.json
module Keybase
  module Request
    class Dump < Base
      def self.latest
        get('dump/latest.json', {})['dump']
      end
    end
  end
end
