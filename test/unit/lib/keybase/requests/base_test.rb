module Keybase
  require_relative '../../../../test_helper'
  
  module Request
    class RequestBaseTest < Minitest::Test
      def setup
        @server_response = Object.new
        @conn = Faraday.new
        @response = OpenStruct.new(body: true)
      end

      def test_get_returns_keybase_response
        Base.stub :conn, @conn do
          @conn.stub :get, nil do
            Keybase::Response.stub :new, @response do
              assert Base.get('foo', {})
            end
          end
        end
      end

      def test_get_passes_params
        @mock = MiniTest::Mock.new
        @mock.expect(:get, @response, ['foo', { 'bar' => 'baz'}])
        Base.stub :conn, @mock do
          Keybase::Response.stub :new, @response do
            Base.get('foo', 'bar' => 'baz')
          end
        end
        @mock.verify
      end

      def test_post_returns_keybase_response
        Base.stub :conn, @conn do
          @conn.stub :post, nil do
            Keybase::Response.stub :new, @response do
              assert Base.post('foo', {})
            end
          end
        end
      end
      
      def test_post_passes_params
        @mock = MiniTest::Mock.new
        @mock.expect(:post, @response, ['foo', { 'bar' => 'baz'}])
        Base.stub :conn, @mock do
          Keybase::Response.stub :new, @response do
            Base.post('foo', 'bar' => 'baz')
          end
        end
        @mock.verify
      end
      
      def test_base_url_defined
        assert defined?(API_BASE_URL)
      end
      
    end
  end
end