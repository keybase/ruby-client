module Keybase
  # @private
  module Request
    API_BASE_URL = 'https://keybase.io'
    class Base

      def self.get(url, params={})
        Keybase::Response.new(conn.get(url, params)).body
      end
      
      def self.post(url, params={})
        response = Keybase::Response.new(conn.post(url, params))
        TokenStore.cookie = response.cookie if response.cookie
        response.body
      end
      
      private
      
      def self.conn
        Faraday.new(:url => API_BASE_URL) do |faraday|
          faraday.path_prefix = "/_/api/1.0"
          faraday.request  :url_encoded
          faraday.headers['Cookie'] = TokenStore.cookie if TokenStore.cookie
          faraday.headers['X-CSRF-Token'] = TokenStore.csrf if TokenStore.csrf
          # faraday.response :logger
          faraday.adapter  Faraday.default_adapter
        end
      end
      
    end
  end
end
