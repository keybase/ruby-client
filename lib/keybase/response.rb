module Keybase
  class Response
    
    attr_reader :body, :cookie
    
    def initialize(server_response)
      @body = JSON.parse(server_response.body)
      @cookie = server_response.headers['Set-Cookie'] ? server_response.headers['Set-Cookie'] : nil
      begin
        Error.raise_unless_successful(@body['status'])
      rescue
        STDERR.puts @body unless defined?(TEST_ENV)
        raise
      end
      @body
    end
    
  end
end
