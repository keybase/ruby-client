module Keybase
  require_relative '../../../test_helper'
  
  class ResponseTest < Test::Unit::TestCase
    def setup
      @response = Object.new
      @response.stubs(body: {'status' => {'code' => 0, 'desc' => 'all fine'}}.to_json)
    end
    
    def test_does_not_raise
      Response.new(@response)  
    end
    
    def test_raises_user_not_found
      @response.stubs(body: {'status' => {'code' => 205, 'desc' => 'User not found'}}.to_json)
      assert_raise_with_message(Keybase::UserNotFoundError, 'User not found') do
        Response.new(@response) 
      end
    end
  end
end
