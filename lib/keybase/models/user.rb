module Keybase
  class User
    
    attr_reader :id, :basics, :invitation_stats, :profile, :emails,
                :public_keys, :private_keys

    def initialize(params)
      @id = params['id']
      @invitation_stats = OpenStruct.new(params['invitation_stats'])
      
      set_basics(params['basics'])             if params['basics']
      set_profile(params['profile'])           if params['profile']
      set_emails(params['emails'])             if params['emails']
      set_public_keys(params['public_keys'])   if params['public_keys']
      set_private_keys(params['private_keys']) if params['private_keys']
    end
    
    def self.lookup(username)
      new(Request::User.lookup(username))
    end
    
    private
    
    def set_basics(params)
      @basics = OpenStruct.new(params.merge(created_at: nil, updated_at: nil))
      @basics.created_at = Time.at(@basics.ctime).to_datetime if @basics.ctime
      @basics.updated_at = Time.at(@basics.mtime).to_datetime if @basics.mtime
    end
    
    def set_profile(params)
      @profile = OpenStruct.new(params.merge(updated_at: nil))
      @profile.updated_at = Time.at(@profile.mtime).to_datetime if @profile.mtime
    end

    def set_emails(params)
      @emails = OpenStruct.new(params)
      params.each do |k,v|
        v.merge!('is_verified?' => (v['is_verified'] == 1 ? true : false))
        @emails.send("#{k}=".to_sym, OpenStruct.new(v))
      end
    end
    
    def set_public_keys(params)
      @public_keys = OpenStruct.new(params)
      params.each do |k,v|
        v.merge!('created_at' => Time.at(v['ctime']).to_datetime)
        v.merge!('updated_at' => Time.at(v['mtime']).to_datetime)
        @public_keys.send("#{k}=".to_sym, OpenStruct.new(v))
      end      
    end
    
    def set_private_keys(params)
      @private_keys = OpenStruct.new(params)
      params.each do |k,v|
        v.merge!('created_at' => Time.at(v['ctime']).to_datetime)
        v.merge!('updated_at' => Time.at(v['mtime']).to_datetime)
        @private_keys.send("#{k}=".to_sym, OpenStruct.new(v))
      end      
    end
  end
end
