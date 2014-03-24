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

    def self.login(email_or_username, passphrase)
      salt, login_session = Request::Root.get_salt_and_login_session(email_or_username)
      pwh = Crypto.scrypt(passphrase, [salt].pack("H*"))
      hmac_pwh = Crypto.hmac_sha512(pwh, Base64.decode64(login_session))
      response = Request::Root.login(email_or_username, hmac_pwh, login_session)
      return new(response['me'])
    end
    
    def post_auth(sig)
      Request::Sig.post_auth(basics.username, sig)
    end
    
    def add_public_key(key)
      Request::Key.add(public_key: key)
    end
    
    def add_private_key(key)
      Request::Key.add(private_key: key)
    end
    
    def revoke_key(kid)
      Request::Key.revoke(kid)
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
