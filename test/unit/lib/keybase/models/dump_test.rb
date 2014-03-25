module Keybase
  
  require_relative '../../../../test_helper'
  
  class DumpTest < Minitest::Test
    def setup
      @dump = Dump.new(EXAMPLE_DUMP)
    end
    
    def test_unix_time_parsed_to_date
      assert_equal "2014-02-24T18:46:31+00:00",
                    @dump.created_at.to_s
    end
    
    def test_dump_all
      Request::Dump.stub :all, [{'dump_id' => 1, 'ctime' => 1393267591},
                                {'dump_id' => 2, 'ctime' => 1393267591}] do
        dumps = Dump.all
        assert_equal 1, dumps[0].id
        assert_equal 2, dumps[1].id
      end    
    end
    
    def test_dump_latest
      Request::Dump.stub :latest, {'dump_id' => 1, 'ctime' => 1393267591} do
        assert_equal 1, Dump.latest.id
        assert_equal '2014-02-24T18:46:31+00:00', Dump.latest.created_at.to_s
      end      
    end
  end
end