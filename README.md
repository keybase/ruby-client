# ruby-client

CLI for keybase.io written for/in Ruby

[![Build Status](https://secure.travis-ci.org/seanhandley/ruby-client.png?branch=master)](http://travis-ci.org/seanhandley/ruby-client)

# Usage

```ruby
require 'keybase'

# Get user information
user = Keybase.lookup('username')
user.basics.username                #=> "chris"
user.profile.bio                    #=> "I am the terror that flaps in the night."
user.emails.primary                 #=> "chris@okcupid.com"
user.emails.primary.is_verified?    #=> false
user.public_keys.primary.kid        #=> "d028ac1542b24a5f77f123ba467873e3ce96a992570a"
user.public_keys.primary.updated_at #=> #<DateTime: 2013-11-05T21:00:12+00:00 ((2456602j,75612s,0n),+0s,2299161j)>
```
