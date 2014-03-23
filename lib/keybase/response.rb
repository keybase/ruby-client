module Keybase
  class Response
    
    attr_reader :body
    
    def initialize(server_response)
      @body = JSON.parse(server_response.body)
      begin
        Error.raise_unless_successful(@body['status'])
      rescue
        STDERR.puts @body
        raise
      end
      @body
    end
    
  end
end
