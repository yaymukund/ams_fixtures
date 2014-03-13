# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ams_fixtures/version'

Gem::Specification.new do |spec|
  spec.name          = 'ams_fixtures'
  spec.version       = AmsFixtures::VERSION
  spec.authors       = ['Mukund Lakshman']
  spec.email         = ['yaymukund@gmail.com']
  spec.summary       = %q{A very specific gem to generate JS fixtures server-side.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rails', '>= 4.0.0'
  spec.add_development_dependency 'activerecord', '>= 4.0.0'
  spec.add_development_dependency 'fabrication', '~> 2.9.8'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0.0.beta'
  spec.add_development_dependency 'sqlite3', '~> 1.3.9'
end
