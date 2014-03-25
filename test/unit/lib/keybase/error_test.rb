module Keybase
  require_relative '../../../test_helper'
  
  class ErrorTest < Minitest::Test
    def setup
      @status =  {'code' => 100, 'fields' => {'username' => 'dsay7984yfhuragh4u3q9fR^&%^%'}, 'desc' => 'Invalid username'}
      @unknown = {'code' => 1337, 'fields' => {'foo' => 'bar'}, 'desc' => 'baz'}
    end
    
    def test_behaviour_with_known_error_code
      assert_raises InputError do
        begin
          Error.raise_unless_successful(@status)
        catch StandardError => e
          assert_equal 'Invalid username. username: dsay7984yfhuragh4u3q9fR^&%^%', e.msg
          raise
        end
      end
    end
    
    def test_behaviour_with_unknown_error_code
      assert_raises Keybase::Error do
        begin
          Error.raise_unless_successful(@unknown)
        catch StandardError => e
          assert_equal 'Error 1337: baz. foo: bar', e.msg
          raise
        end
      end
    end
  end
end
