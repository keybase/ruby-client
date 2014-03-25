require_relative '../../../../../test_helper'

module Keybase
  module Request
    class DumpAllTest < Minitest::Test
      def setup
        @response = { 'dumps' => [EXAMPLE_DUMP, EXAMPLE_DUMP] }
      end

      def test_all_returns_dumps
        Base.stub :get, @response do
          assert_equal 2, Request::Dump.all.count
        end
      end
    end
  end
end
