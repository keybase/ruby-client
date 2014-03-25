module Keybase
  # @private
  class Error < StandardError
    def self.raise_unless_successful(status)
      return if status['code'] == 0
      message = status['fields'] ? error_with_fields(status) : status['desc']
      err = Keybase::errors[status['code']]
      if err
        raise err, message
      else
        raise Keybase::Error, "Error #{status['code']}: #{message}"
      end
    end
    
    def self.error_with_fields(status)
      "#{status['desc']}. #{status['fields'].map{|k,v| "#{k.to_s}: #{v.to_s}"}.join(',')}"
    end
  end
  
  class UserNotFoundError < StandardError; end
  class InputError < StandardError; end
  class BadPasswordError < StandardError; end
  class BadSessionError < StandardError; end
  class CSRFVerificationError < StandardError; end
  
  private
    
  def self.errors
    {
      100 => InputError,
      202 => BadSessionError,
      205 => UserNotFoundError,
      204 => BadPasswordError,
      222 => CSRFVerificationError
    }
  end 
end
