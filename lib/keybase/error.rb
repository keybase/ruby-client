module Keybase
  class Error
    def self.raise_unless_successful(status)
      return if status['code'] == 0
      message = status['fields'] ? error_with_fields(status) : status['desc']
      raise Keybase::errors[status['code']], message
    end
    
    def self.error_with_fields(status)
      "#{status['desc']}. #{status['fields'].map{|k,v| "#{k.to_s}: #{v.to_s}"}.join(',')}"
    end
  end
  
  class UserNotFoundError < StandardError; end
  class InputError < StandardError; end
  
  private
    
  def self.errors
    {
      100 => InputError,
      205 => UserNotFoundError
    }
  end 
end
