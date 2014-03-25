require_relative '../../../../../test_helper'

module Keybase
  module Request
    class DumpLatestTest < Minitest::Test
      def setup
        @response = { 'dump' => EXAMPLE_DUMP }
      end

      def test_latest_returns_dump
        Base.stub :get, @response do
          assert_equal "472eba4586993583b395b00e", Request::Dump.latest['dump_id']
        end
      end
    end
  end
end
