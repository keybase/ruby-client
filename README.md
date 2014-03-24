# ruby-client

CLI for keybase.io written for/in Ruby

[![Build Status](https://secure.travis-ci.org/seanhandley/ruby-client.png?branch=master)](http://travis-ci.org/seanhandley/ruby-client)

## Usage

```ruby
require 'keybase'

# Login
me = Keybase.login('chris', 'passphrase')
me.basics.username          #=> "chris"
me.private_keys.primary.kid #=> "a140c70404a13370f7..."

# Key Add
me.add_public_key("-----BEGIN PGP PUBLIC...")  #=> "0101d9d962be6ee38cdadedd6..." (key_id)
me.add_private_key("hKRib2R5gqRwcml2gqRkY...") #=> "a140c70404a13370f7..." (key_id)

# Key Revoke
me.revoke_key("a140c70404a13370f7...") #=> true

# Signature post auth
me.post_auth('----- BEGIN PGP MESSAGE ----- ...') #=> "fd2667b9b396150603ea0b567eaf3334c3..." (auth_token)

# Get user information
user = Keybase.lookup('username')
user.basics.username                #=> "chris"
user.profile.bio                    #=> "I am the terror that flaps in the night."
user.emails.primary                 #=> "chris@okcupid.com"
user.emails.primary.is_verified?    #=> false
user.public_keys.primary.kid        #=> "d028ac1542b24a5f77f123ba467873e3ce96a992570a"
user.public_keys.primary.updated_at #=> #<DateTime: 2013-11-05T21:00:12+00:00 ((2456602j,75612s,0n),+0s,2299161j)>

# Dumps

dump = Keybase.dump_latest
dump.full_data_sha256    #=> "66e72ba9906e8eec544ae74ee22c249e6879ddcd856df0c9679d7a79f26ce259" 
dump.changes_from_parent #=> "https://s3.amazonaws.com/keybase_data_dumps/2014-03-24-18-06-15--1b43379e593576fe395ad90e--changes.json"

dumps = Keybase.dump_all #=> [#<Keybase::Dump:0x00000102584280...]
```
