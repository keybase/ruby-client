module Keybase
  require_relative '../../../../test_helper'
  
  module Request
    class RequestBaseTest < Test::Unit::TestCase
      
      def setup
        @url = "foo"
        @params = {'bar' => 'baz'}
        @server_response = Object.new
      end
      
      def test_get_passes_off_correctly
        # 1) Calls get on the conn object using the url/params
        conn_stub = Object.new
        conn_stub.expects(:get).with(@url, @params)
        # 2) The mock object expects '.body' to be called  
        @server_response.stubs(:body => '')
        # 3) Creates a new response object, represented by a mock
        Keybase::Response.expects(:conn).returns(conn_stub)
        Keybase::Response.expects(:new).returns(@server_response)

        # Make the call
        Request::Base.get(@url, @params)      
      end
      
      def teardown
        Keybase::Response.unstub(:conn)
        Keybase::Response.unstub(:new)
      end

    end
  end
end