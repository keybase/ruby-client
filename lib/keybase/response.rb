module Keybase
  # @private
  class Response
    
    attr_reader :body, :cookie
    
    def initialize(server_response)
      @body = JSON.parse(server_response.body)
      Error.raise_unless_successful(@body['status'])
      @cookie = server_response.headers['Set-Cookie'] ? server_response.headers['Set-Cookie'] : nil
    end
    
  end
end
