module Keybase
  class Response
    
    attr_reader :body
    
    def initialize(server_response)
      @body = JSON.parse(server_response.body)
      Error.raise_unless_successful(@body['status'])
      @body
    end
    
  end
end
