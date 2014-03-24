module Keybase
  class Dump
    
    attr_reader :id, :full_data, :full_data, :full_data_sha256, :parent_dump_id, :changes_from_parent,
                :changes_sha256, :created_at

    def initialize(params)
      @id = params['dump_id']
      @full_data = params['full_data']
      @full_data_sha256 = params['full_data_sha256']
      @parent_dump_id = params['parent_dump_id']
      @changes_from_parent = params['changes_from_parent']
      @changes_sha256 = params['changes_sha256']
      @created_at = Time.at(params['ctime']).to_datetime
    end
  
    def self.all
      Request::Dump.all.map{|dump| new(dump)}
    end
  
    def self.latest
      new(Request::Dump.latest)
    end
  end
end