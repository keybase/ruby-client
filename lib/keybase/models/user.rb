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
      # pwh = scrypt(passphrase, hex2bin(salt), N=2^15, r=8, p=1, dkLen=224)[192:224]
      # The parameters r, p, and buflen* must satisfy r * p < 2^30 and buflen <= (2^32 - 1) * 32.
      n, r, p, klen = 2**15, 8, 1, 224
      pwh = SCrypt::Engine.scrypt(passphrase, salt, n, r, p, klen)
      digest = OpenSSL::Digest::SHA512.new
      hmac_pwh = OpenSSL::HMAC.hexdigest(digest, pwh, Base64.decode64(login_session))
      result = Request::Root.login(email_or_username, hmac_pwh, login_session)
      puts result
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
