module Keybase
  require_relative '../../../test_helper'
  
  class ResponseTest < Minitest::Test
    def setup
      @response = OpenStruct.new(body: nil)
    end
    
    def test_does_not_raise
      @response.stub :body, {'status' => {'code' => 0, 'desc' => 'all fine'}}.to_json do
        Response.new(@response)  
      end
    end
    
    def test_raises_user_not_found
      @response.stub :body, {'status' => {'code' => 205, 'desc' => 'User not found'}}.to_json do
        assert_raises(Keybase::UserNotFoundError, 'User not found') do
          Response.new(@response) 
        end
      end
    end
  end
end
