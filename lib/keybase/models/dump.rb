module Keybase
  # A dump object containing hashes, IDs and data links
  # from which a mirror can be configured.
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

    # Retrieve the dump history from Keybase
    #
    # @return [[Keybase::Dump]] a collection of all Keybase dumps  
    def self.all
      Request::Dump.all.map{|dump| new(dump)}
    end

    # Retrieve the latest dump from Keybase
    #
    # @return [Keybase::Dump] latest Keybase dump 
    def self.latest
      new(Request::Dump.latest)
    end
  end
end