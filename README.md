# Keybase Gem

API client gem for [keybase.io](https://keybase.io).

[![Build Status](https://secure.travis-ci.org/seanhandley/ruby-client.png?branch=master)](http://travis-ci.org/seanhandley/ruby-client)

## Installing

```
gem install keybase
```

or

(in Gemfile or .gemspec)
```ruby
gem 'keybase'
```

then

```ruby
require 'keybase'
````

## Usage

Keybase is two things.

1) A public, publicly-auditable directory of keys and identity proofs.
2) A protocol for accessing the directory.

### Login

Upon login, you'll get back a user object. Your user object is essentially a large dictionary (wrapped as a Ruby object) and contains pretty much everything about you and your account. (See the [user objects](https://keybase.io/__/api-docs/1.0#user-objects) page in the API documentation for more info.)

The login will also initiate an ongoing session which allows the authenticated actions: `key/add`, `key/revoke`, `sig/post_auth`

```ruby
me = Keybase.login('chris', 'passphrase')
me.basics.username          #=> "chris"
me.private_keys.primary.kid #=> "a140c70404a13370f7..."
```

### Key Add

An uploaded public key should be an armored PGP key. An uploaded private key should be in [P3SKB](https://keybase.io/__/api-docs/1.0#p3skb-format) format.

Note: You can't upload the private before the public.

```ruby
me.add_public_key("-----BEGIN PGP PUBLIC...") 
#=> "0101d9d962be6ee38cdadedd6..." (key_id)
me.add_private_key("hKRib2R5gqRwcml2gqRkY...")
#=> "a140c70404a13370f7..." (key_id)
```

### Key Revoke

Currently, the only acceptable type of revocation is a simple delete, which means you just delete the key from Keybase. It's technically not a revocation at all. In the near future, you will be able to post revocations to the server, too.

```ruby
me.revoke_key("a140c70404a13370f7...") #=> true
```

### Signature Post Auth

Post a self-signed authentication certificate, so that future attempts to load a user session can succeed.

The payload of the signature should take the form of other keybase signatures, like self-signing keys, or proving ownership of remote accounts.

An example looks like:

```json
{
    "body": {
        "key": {
            "fingerprint": "da99a6ebeca98b14d944cb6e1ca9bfeab344f0fc",
            "host": "keybase.io",
            "key_id": "1ca9bfeab344f0fc",
            "uid": "15a9e2826313eaf005291a1ae00c3f00",
            "username": "taco422107"
        },
        "nonce": null,
        "type": "auth",
        "version": 1
    },
    "ctime": 1386537779,
    "expire_in": 86400,
    "tag": "signature"
}
```

The client can provide an optional nonce to randomize the signatures. The server will check the signature for validatity, and on success, will return an auth_token, which is the SHA-256 hash of the full signature body, from the "---- BEGIN" through to the ---- END PGP MESSAGE ----.

```ruby
me.post_auth('----- BEGIN PGP MESSAGE ----- ...')
#=> "fd2667b9b396150603ea0b567eaf3334c3..." (auth_token)
```

### Get User Information

A user object is a large dictionary (wrapped as a Ruby object) and contains pretty much everything about a user that you have access to. 

```ruby
user = Keybase.lookup('username')
user.basics.username                
#=> "chris"
user.profile.bio                   
#=> "I am the terror that flaps in the night."
user.emails.primary                 
#=> "chris@okcupid.com"
user.emails.primary.is_verified?    
#=> false
user.public_keys.primary.kid        
#=> "d028ac1542b24a5f77f123ba467873e3ce96a992570a"
user.public_keys.primary.updated_at
#=> #<DateTime: 2013-11-05T21:00:12+00:00 ((2456602j,75612s,0n),+0s,2299161j)>
```

### Dumps

Dumps represent a history of the public dumps of the site. You can use it to track or mirror the site as you wish. If you have a previous dump of the site, you can apply changes to sync up without downloading the entire site.

```ruby
dump = Keybase.dump_latest
dump.full_data_sha256
#=> "66e72ba9906e8eec544ae74ee22c249e6879ddcd856df0c9679d7a79f26ce259" 
dump.changes_from_parent
#=> "https://s3.amazonaws.com/keybase_data_dumps/2014-03-24-18-06-15--1b43379e593576fe395ad90e--changes.json"

dumps = Keybase.dump_all #=> [#<Keybase::Dump:0x00000102584280...]
```

## Further Reading

Please check out the [Keybase API Documentation](https://keybase.io/__/api-docs/1.0) for a comprehensive explanation of the API and its capabilities.