Gem::Specification.new do |gem|
  gem.name = 'keybase'
  gem.version = '0.0.0'
  gem.date = '2013-10-25'
  gem.summary = 'keybase'
  gem.description = 'CLI for keybase.io'
  gem.authors = [ 'Max Krohn' ]
  gem.email = 'themax@gmail.com'
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/keybase/ruby-client'
  gem.license = 'BSD-3-Clause'
  
  gem.required_ruby_version = '>= 2.1.0'
  
  # Runtime Dependencies
  gem.add_runtime_dependency 'scrypt', '>= 1.2.1'
  gem.add_runtime_dependency 'faraday', '>= 0.9.0'
  
  # Development Dependencies
  gem.add_development_dependency 'vcr', '>= 2.8.0'
  gem.add_development_dependency 'webmock', '>= 1.8.0'
  gem.add_development_dependency 'minitest', '>= 5.3.1'
end
